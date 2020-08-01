#!/bin/sh
#===============================================================================
# Copyright 1985-2019 Intel Corporation All Rights Reserved.
#
# The source code,  information  and material  ("Material") contained  herein is
# owned by Intel Corporation or its  suppliers or licensors,  and  title to such
# Material remains with Intel  Corporation or its  suppliers or  licensors.  The
# Material  contains  proprietary  information  of  Intel or  its suppliers  and
# licensors.  The Material is protected by  worldwide copyright  laws and treaty
# provisions.  No part  of  the  Material   may  be  used,  copied,  reproduced,
# modified, published,  uploaded, posted, transmitted,  distributed or disclosed
# in any way without Intel's prior express written permission.  No license under
# any patent,  copyright or other  intellectual property rights  in the Material
# is granted to  or  conferred  upon  you,  either   expressly,  by implication,
# inducement,  estoppel  or  otherwise.  Any  license   under such  intellectual
# property rights must be express and approved by Intel in writing.
#
# Unless otherwise agreed by Intel in writing,  you may not remove or alter this
# notice or  any  other  notice   embedded  in  Materials  by  Intel  or Intel's
# suppliers or licensors in any way.
#===============================================================================

PROD_DIR="/opt/intel/compilers_and_libraries_2020.2.254/linux"
INTEL_TARGET_ARCH=
INTEL_TARGET_PLATFORM=linux
INTEL_HOST_PLATFORM=`uname`

COMPILERVARS_ARGV=$#
if [ ${COMPILERVARS_ARGV} -eq 0 ]; then
    if [ "$COMPILERVARS_ARCHITECTURE" != '' ]; then
        INTEL_TARGET_ARCH=$COMPILERVARS_ARCHITECTURE
    fi
    if [ "$COMPILERVARS_PLATFORM" != '' ]; then
        INTEL_TARGET_PLATFORM=$COMPILERVARS_PLATFORM
    fi
fi

while [ $# -gt 0 ]
do
    opt="$1"
    case $opt in
    -arch)
        shift
        INTEL_TARGET_ARCH="$1"
        shift
        ;;
    -platform)
        shift
        INTEL_TARGET_PLATFORM="$1"
        shift
        ;;
    *)
        INTEL_TARGET_ARCH="$1"
        shift
        ;;
    esac
done

if [ "${INTEL_TARGET_ARCH}" != "ia32" -a "${INTEL_TARGET_ARCH}" != "intel64" -o \
      "${INTEL_TARGET_PLATFORM}" != "android" -a \
      "${INTEL_TARGET_PLATFORM}" != "linux" -a \
      "${INTEL_TARGET_PLATFORM}" != "mac" -o \
      "${INTEL_HOST_PLATFORM}" = "Darwin" -a "${INTEL_TARGET_ARCH}" != "intel64" ]; then

    echo "compilervars.sh [-arch] <arch> [-platform <platform>]"
    echo ""
    echo "  <arch> must be one of the following:"
    if [ "${INTEL_HOST_PLATFORM}" != "Darwin" ]; then
        echo "      ia32           : Set up for IA-32 target."
    fi
    echo "      intel64        : Set up for Intel(R)64 target."
    echo "  <platform> must be of the following:"
    if [ "${INTEL_HOST_PLATFORM}" = "Darwin" ]; then
        echo "      linux          : Set to Linux* target."
        echo "      mac            : Set to macOS* target.(default)"
    else
        echo "      android        : Set to Android* target."
        echo "      linux          : Set to Linux* target.(default)"
    fi
    echo ""
    echo "If the arguments to the sourced script are ignored (consult docs"
    echo "for your shell) the alternative way to specify target is environment"
    echo "variables COMPILERVARS_ARCHITECTURE to pass <arch> to the script"
    echo "and COMPILERVARS_PLATFORM to pass <platform>"

    return 1
fi

if [ ${INTEL_TARGET_PLATFORM} = "mac" ]; then
    INTEL_TARGET_PLATFORM="linux"
fi

if [ ${COMPILERVARS_ARGV} -eq 0 ]; then
    #pass default values via COMPILERVARS_*
    if [ "$COMPILERVARS_ARCHITECTURE" = '' ]; then
        COMPILERVARS_ARCHITECTURE=$INTEL_TARGET_ARCH
    fi
    if [ "$COMPILERVARS_PLATFORM" = '' ]; then
        COMPILERVARS_PLATFORM=$INTEL_TARGET_PLATFORM
    fi
    INTEL_TARGET_ARCH=
    INTEL_TARGET_PLATFORM=
fi

# ---------------------function fix_environment--------------------------------
fix_environment() {
  remove_duplicate_paths "PATH"
  remove_duplicate_paths "LD_LIBRARY_PATH"
}
# ----------------------function fix_environment-------------------------------

# ------------------function remove_duplicate_paths----------------------------
remove_duplicate_paths() {
  local arg=$1
  eval "aurPatchWrongPath=\"\${arg}\""
  local arr=(`echo ${aurPatchWrongPath} | sed 's/:/\n/g'`)
  local fixarr=()
  local found=
  local i=0
  for var in ${arr[*]}; do
    found=0
    for dup in ${fixarr[*]}; do
      if [ "${dup}" = "${var}" ]; then
        found=1
        break
      fi
    done
    if [ "${found}" = "0" ]; then
      if [ "${#fixarr[*]}" = "0" ]; then
        fixarr=("${var}")
      else
        fixarr=("${fixarr[*]} ${var}")
      fi
    fi
  done
  local fixarg=`echo ${fixarr[*]} | sed 's/ /:/g'`
  eval export \$arg="${fixarg}"
}
# ------------------function remove_duplicate_paths----------------------------

if [ -e "${PROD_DIR}/daal/bin/daalvars.sh" ]; then
    . "${PROD_DIR}/daal/bin/daalvars.sh" ${INTEL_TARGET_ARCH}
    fix_environment
fi

if [ -e "${PROD_DIR}/../../debugger_2020/bin/debuggervars.sh" ]; then
    . "${PROD_DIR}/../../debugger_2020/bin/debuggervars.sh" ${INTEL_TARGET_ARCH}
    fix_environment
fi

if [ -e "${PROD_DIR}/tbb/bin/tbbvars.sh" ]; then
    . "${PROD_DIR}/tbb/bin/tbbvars.sh" ${INTEL_TARGET_ARCH} ${INTEL_TARGET_PLATFORM}
    fix_environment
fi

if [ -e "${PROD_DIR}/pstl/bin/pstlvars.sh" ]; then
    . "${PROD_DIR}/pstl/bin/pstlvars.sh" ${INTEL_TARGET_ARCH}
    fix_environment
fi

if [ -e "${PROD_DIR}/mkl/bin/mklvars.sh" ]; then
    . "${PROD_DIR}/mkl/bin/mklvars.sh" ${INTEL_TARGET_ARCH}
    fix_environment
fi

if [ -e "${PROD_DIR}/ipp/bin/ippvars.sh" ]; then
    . "${PROD_DIR}/ipp/bin/ippvars.sh" ${INTEL_TARGET_ARCH} ${INTEL_TARGET_PLATFORM}
    fix_environment
fi

if [ -e "${PROD_DIR}/ippcp/bin/ippcpvars.sh" ]; then
    . "${PROD_DIR}/ippcp/bin/ippcpvars.sh" ${INTEL_TARGET_ARCH} ${INTEL_TARGET_PLATFORM}
    fix_environment
fi

if [ -e "${PROD_DIR}/mpi/intel64/bin/mpivars.sh" ]; then
    if [ "${INTEL_TARGET_ARCH}" = "intel64" -o "${COMPILERVARS_ARCHITECTURE}" = "intel64" ]; then
        . "${PROD_DIR}/mpi/intel64/bin/mpivars.sh"
        fix_environment
    fi
fi

if [ -e "${PROD_DIR}/pkg_bin/compilervars_arch.sh" ]; then
    . "${PROD_DIR}/pkg_bin/compilervars_arch.sh" ${INTEL_TARGET_ARCH} ${INTEL_TARGET_PLATFORM}
    fix_environment
fi

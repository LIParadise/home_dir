#!/usr/bin/env bash
CXX=g++ CC=gcc CPPFLAGS="-O2 -march=native" CXXFLAGS="-O2 -march=native" python scripts/mk_make.py --python

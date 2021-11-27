. "$HOME/.cargo/env"
# fcitx5
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XIM=fcitx
export XIM_ARGS="-rd"
# Mozila Firefox wayland support
export MOZ_ENABLE_WAYLAND=1
# QT support under wayland
# https://wiki.archlinux.org/title/Wayland#Qt
# Requires `qt5-wayland` or `qt6-wayland` on Archlinux
export QT_QPA_PLATFORM=wayland

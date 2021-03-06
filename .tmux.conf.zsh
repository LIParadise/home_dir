bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind C-h resize-pane -L 5
bind C-j resize-pane -D 5
bind C-k resize-pane -U 5
bind C-l resize-pane -R 5

bind J swap-pane -D
bind K swap-pane -U

unbind C-b
set -g prefix 'C-\'
bind 'C-\' send-prefix
# set-option -g default-shell /bin/zsh
set -g default-terminal "xterm-256color"

set -g default-command "exec /bin/zsh"
set -g history-limit 3000

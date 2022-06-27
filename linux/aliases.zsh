alias find_preview="fdfind --type f | fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'"
alias fp='find_preview'
alias find='fdfind --type f | fzf'
alias files='broot'

function laptop_mode() {
  gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch']"
  gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch', 'ctrl:swap_lwin_lctl']"
}

function desktop_mode() {
  gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch']"
  gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch', 'altwin:swap_lalt_lwin']"
}

# if test -z ${WSL_DISTRO_NAME}
# then
#   alias open='xdg-open'
# else
#   alias open='wsl-open'
# fi

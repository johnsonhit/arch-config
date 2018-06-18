# Set urxvt style
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Set ibus
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
ibus-daemon -x -r -d

# Start i3
exec i3 > ~/.local/share/i3/i3.log 2>&1

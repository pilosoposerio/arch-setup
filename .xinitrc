xset +fp /usr/share/fonts/termsyn/
xset +fp /usr/share/fonts/joypixels/
xset +fp /usr/share/fonts/misc/
xset +fp /usr/share/fonts/cantarell/
xset +fp /usr/share/fonts/noto/
xset fp rehash

xmodmap /home/cp/.kb_mod
xrdb .Xresources
exec bspwm

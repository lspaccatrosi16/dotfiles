if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ] && [ "${XDG_VTNR:-O}" -eq 1 ]; then
    exec dbus-run-session Hyprland
fi

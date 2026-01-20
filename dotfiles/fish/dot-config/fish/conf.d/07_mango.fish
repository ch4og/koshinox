if status is-interactive && test -z "$WAYLAND_DISPLAY" && test "$(cat /sys/class/tty/tty0/active)" = "tty1" && test -z "$SSH_CONNECTION"
    if set -q KMS_START_SCRIPT
        exec $KMS_START_SCRIPT mango
    else
        exec mango
    end
end

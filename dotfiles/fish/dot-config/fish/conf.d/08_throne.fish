if status is-interactive
    if not pgrep -x Throne >/dev/null
        env QT_QPA_PLATFORM=offscreen Throne >/dev/null 2>&1 &
    end
end

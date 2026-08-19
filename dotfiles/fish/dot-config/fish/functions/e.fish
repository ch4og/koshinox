function e
    if test (count $argv) -eq 0
        set argv .
    end

    set -l has_frame (emacsclient -e "(catch 'found (dolist (f (frame-list) 0) (when (and (display-graphic-p f) (frame-visible-p f)) (throw 'found 1))))" 2>/dev/null)

    if test "$has_frame" = 1
        emacsclient -n $argv
    else
        if test -z "$has_frame"
            emacs --daemon
        end
        emacsclient -c -n $argv
    end
end

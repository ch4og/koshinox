function cc -d "Wrapper for claude code"
    if test (count $argv) -eq 0
        claude
    else if test "$argv[1]" = "s"
        claude -r
    else if test "$argv[1]" = "l"
        claude -c
    else
        claude "$argv"
    end
end

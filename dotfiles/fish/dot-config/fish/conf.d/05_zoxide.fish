function z --wraps=__zoxide_z --description 'alias z=__zoxide_z'
    if test (count $argv) -eq 1
        switch $argv[1]
            case shi
                cd ~/code/shikanox
                return
        end
    end

    __zoxide_z $argv
end

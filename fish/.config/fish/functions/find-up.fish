# https://github.com/nvm-sh/nvm/issues/110#issuecomment-442955314
function find-up --description 'Find file recursively in parent directory'
    set path (pwd)
    while test "$path" != "/" ; and not test -f "$path/$argv[1]"
        set path (dirname $path)
    end
    if test -f "$path/$argv[1]"
        echo "$path/$argv[1]"
    else
        echo ""
    end
end

function ga --description 'Like git add, but defaults to . if no arguments given, rather than erroring.'
    if [ -z "$argv" ]
        git add .
    else
        git add $argv
    end
end

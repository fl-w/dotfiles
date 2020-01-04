function coln --description 'Splits its input on whitespace and prints the column indicated.'
    while read -l input
        echo $input | awk '{print $'$argv[1]'}'
    end
end

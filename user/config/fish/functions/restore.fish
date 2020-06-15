function rbak --argument file --description 'Rename file.bak to file.' 
    mv $file (echo $file | sed s/.bak//)
end

function split-file-ext --description 'split extension and name given a file name/path' --argument file
  set file (basename $file)
  set --local ext (echo $file | awk -F. '{print $NF}')
  set --local name (echo $file | awk -F. '{print $1}')

  echo "$name $ext"
end

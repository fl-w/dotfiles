function wexec --description "use inotifywait to watch input files and exec command"
  inotifywait -q -m --event close_write --format '%w' $argv[1..-2] |
  while read -l filename
   printf 'read $filename'
   eval (string replace '{file}' '$filename' $argv[-1])
 end
end

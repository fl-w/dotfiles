function run-pipr --description "Runs pipr on current prompt"
  set -l commandline (commandline -b)
  pipr --out-file /tmp/pipr_out --default "$commandline"
  set -l result (cat /tmp/pipr_out)
  commandline -r $result
  commandline -f repaint
end

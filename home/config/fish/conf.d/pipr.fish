function run-pipr --description "Runs pipr on current prompt"
    set -l pipr_out (mktemp --suffix=fishpipr)

    pipr --out-file $pipr_out --default (commandline -b)
    and begin
        commandline -r (cat $pipr_out)
        commandline -f repaint # reset commandline
    end

    rm $pipr_out
end

# Pipr binding
has pipr; and bind \ca run-pipr

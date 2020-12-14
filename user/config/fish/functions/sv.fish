function _run_cmd 
    if [ "$UID" = 0 ]
        command $argv
    else
        eval "sudo $argv"
    end
end

function sv --description 'wrapper function for sv to add (dis)/enable subcommand' 
    if test (count $argv) -gt 0
        switch "$argv[1]"
            case 'enable'
                set -l service "$argv[2]"
                if test -z $service
                    echo -e "usage: sv enable service ..."
                else
                    if [ -d /etc/runit/sv/$service ]
                        [ ! -L "/run/runit/service/$service" ]
                         and  _run_cmd ln -s /etc/runit/sv/$service /run/runit/service

                        echo "sv-enable: symlinked /etc/runit/sv/$service -> /run/runit/service"
                        echo "           start the service with 'sv start $service'"
                    else
                        echo "sv-enable: service not found in /etc/run/sv: $service"
                    end
                end
            case '*'
                _run_cmd sv $argv[1..-1]
        end
    else
        command sv
    end

end

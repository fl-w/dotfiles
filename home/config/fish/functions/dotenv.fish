function dotenv --description 'Load environment variables from env file'
  argparse 'v/verbose' 'x/export' 'q/quiet' -- $argv

  set -q argv[1]; or set -a argv ".env"

  for envfile in $argv
    if not test -r $envfile
      set -q _flag_quiet
        and echo "Error: cannot read $envfile" 1>&2
      return 1
    else
      for line in (command cat $envfile)
        if test (echo "$line" | sed -E 's/^[[:space:]]*(.).+$/\\1/g') != "#"
          set keyvalue (echo $line | string split -m1 =)
          if not test -z $keyvalue[1]
            # print key is verbose flag is present
            set -q _flag_verbose; and echo $keyvalue[1]
            # declare parsed keyvalue pair
            eval set -g $_flag_x $keyvalue[1] $keyvalue[2]
          end
        end
      end
    end
  end
end

function __auto_source_dotenv --on-variable PWD --description 'Source .env file on directory change'
  status --is-command-substitution; and return
  dotenv -x
end

function dotenv --description 'Load environment variables from env file'
  argparse 'q/quiet' 'x/export' -- $argv

  set -q argv[1]
    or set -a argv ".env"

  for envfile in $argv
    if not test -r $envfile
      echo "Error: cannot read $envfile" 1>&2
    else
      for line in (command cat $envfile)
        if test (echo $line | sed -E 's/^[[:space:]]*(.).+$/\\1/g') != "#"
          set keyvalue (echo $line |tr = \n)

          if not test -z $keyvalue[1]
            # print key is quiet flag is not present
            set -q _flag_quiet
              or echo $keyvalue[1]
            # declare parsed keyvalue pair
            set -g $_flag_x $keyvalue[1] $keyvalue[2]
          end

        end
      end
    end
  end

end

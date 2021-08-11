function dotenv --description 'Load environment variables from .env file' -a envfile
  set -q envfile[1]; or set envfile ".env"

  if test -r $envfile
    for i in (command cat $envfile)
      if test (echo $i | sed -E 's/^[[:space:]]*(.).+$/\\1/g') != "#"
        set arr (echo $i |tr = \n)
        not test -z $arr[1]; and set -gx $arr[1] $arr[2]
      end
    end
  end
end

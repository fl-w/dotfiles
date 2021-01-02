function new --argument project --argument desc --description "Create a new directory of the project name, enter it, initialize git, and create a git repo."
    src
    if test -d $project
        echo "Error: $project is already a project name" 1>&2
    else
        mc $project
        git init
        hub create -d (test -n "$desc"; and echo $desc; or echo (basename (pwd)))
    end
end

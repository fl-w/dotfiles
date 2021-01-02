function conf -a name -d "open directory in config home with editor"
    "$EDITOR $XDG_CONFIG_HOME/$name" 
end

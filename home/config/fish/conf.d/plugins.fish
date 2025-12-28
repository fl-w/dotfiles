# Automatically install fundle (Warning: dangerous on bad connections)
if not functions -q fundle
  eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin 'fl-w/ortega'
fundle plugin 'jethrokuan/z'
fundle plugin 'oh-my-fish/plugin-await'
fundle plugin 'oh-my-fish/plugin-license'
fundle plugin 'nakulj/auto-venv'

# auto install fundle plugins
for plugin in (fundle list -s)
  if not test -d (__fundle_plugins_dir)/$plugin
    fundle install
    return
  end
end

fundle init

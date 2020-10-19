function auri -a pkg --description="Download and install a package from the AUR"
  if test -z $pkg
    echo "Syntax: auri <package>"
    return 1
  end

  set -q _CACHE_DIR; or set _CACHE_DIR $HOME/.cache/aur

  mkdir -p $_CACHE_DIR

  if [ -d $_CACHE_DIR/$pkg ]
    pushd $_CACHE_DIR/$pkg
    git reset HEAD --hard && git pull
  else
    git clone https://aur.archlinux.org/$pkg.git $_CACHE_DIR/$pkg
    pushd $_CACHE_DIR/$pkg
  end

  makepkg --clean --install --syncdeps
  and popd
end

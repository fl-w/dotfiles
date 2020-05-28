function find_image_path --argument image
  set -l dirs (pwd) /var/lib/libvirt/images/ $HOME/images/ $HOME/vms/
  for dir in $dirs
    for ext in "" ".raw" ".qcow2" ".qcow"
      set --local file $dir$image$ext
      if test -f $file; printf $file; return; end
    end
  end
end

function qemu-run --argument image
  # find image file
  set --local file (find_image_path $image)

  if ! test -n "$file"
    echo "no image file found for $image"
    return 1
  end

  set format (split-file-ext $file | coln 2)

  set --local cmd qemu-system-x86_64 -enable-kvm -m 4096M \
        -drive if=pflash,format=raw,readonly,file=/usr/share/ovmf/x64/OVMF_CODE.fd \
        -cdrom $HOME/vms/imgs/archlinux.iso -boot d \
        -drive file=$file,format=$format
        # -soundhw hda \
  echo $file

  test -w "$file"; or echo "[*] running as sudo"; set cmd sudo $cmd
  command $cmd
end

function find_image_file --argument image
  set -l dirs "" /var/lib/libvirt/images/ $HOME/images/ $HOME/vms/
  for dir in $dirs
    for ext in "" ".qcow2" ".raw" ".qcow"
      set file $dir$image$ext
      if test -f $file; printf $file; return; end
    end
  end
end

function qemu-run --argument image
  set drive (find_image_file $image)

  if test -n "$drive"
    echo "found $drive"
  else
    echo "no image file found for $image"
    return 1
  end

    # find image file

  set cmd qemu-system-x86_64 -enable-kvm -m 4096M -soundhw hda \
        -drive if=pflash,format=raw,readonly,file=/usr/share/ovmf/x64/OVMF_CODE.fd \
        -cdrom $HOME/vms/imgs/archlinux.iso -boot d \
        -drive file=$drive

  if test -r $drive
    $cmd
  else
    echo "running as sudo"
    sudo $cmd
  end
end

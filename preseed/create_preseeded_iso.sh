# in wsl as root

get_script_dir() {
  # Get the directory of the currently running script
  local script_dir=$(dirname "$(realpath "$0")")
  echo "$script_dir"
}

DIRNAME=$(get_script_dir)

ROOT_PATH=$DIRNAME
IMAGE="debian-12.9.0-amd64-netinst"

echo "Root path: $ROOT_PATH"

# prerequesites
apt-get install -y genisoimage

# cleanup
chmod +w -R /mnt/iso
rm -rf /mnt/iso
rm -rf /root/extracted_iso

# mount iso
mkdir /mnt/iso
mount -o loop "${ROOT_PATH}/iso/${IMAGE}.iso" /mnt/iso

# copy file and unmount
cp -r /mnt/iso "/root/extracted_iso"
umount /mnt/iso

# add custom config
cp -f $ROOT_PATH/config/isolinux/menu.cfg /root/extracted_iso/isolinux/menu.cfg
cp $ROOT_PATH/config/boot/grub.cfg /root/extracted_iso/boot/grub/grub.cfg
cp $ROOT_PATH/config/preseed.cfg /root/extracted_iso/preseed.cfg

# change timeout
chmod +w /root/extracted_iso/isolinux/isolinux.cfg
sed -i "s/timeout 0/timeout 10/g" /root/extracted_iso/isolinux/isolinux.cfg
chmod -w /root/extracted_iso/isolinux/isolinux.cfg
chmod +w /root/extracted_iso/isolinux/prompt.cfg
sed -i "s/timeout 0/timeout 10/g" /root/extracted_iso/isolinux/prompt.cfg
chmod -w /root/extracted_iso/isolinux/prompt.cfg

# repack iso
genisoimage -o /root/debian_preseed.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -r /root/extracted_iso

cp /root/debian_preseed.iso ${ROOT_PATH}/iso/${IMAGE}_preseed.iso
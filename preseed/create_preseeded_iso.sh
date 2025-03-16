# in linux/wsl as root

get_script_dir() {
  # Get the directory of the currently running script
  local script_dir=$(dirname "$(realpath "$0")")
  echo "$script_dir"
}

DIRNAME=$(get_script_dir)

# target ISO
IMAGE="debian-12.9.0-amd64-netinst"
# preseed folder
ROOT_PATH=$DIRNAME
# temporary working folder (extracted iso)
EXTRACTED_PATH="/root/extracted_iso"

echo "LOG: Root path: $ROOT_PATH"

### prerequesites

echo "LOG: Install"
apt-get install -y xorriso

### cleanup

echo "LOG: Cleanup"
chmod +w -R /mnt/iso
rm -rf /mnt/iso
rm -rf $EXTRACTED_PATH
umount /mnt/iso 2>/dev/null

### mount

echo "LOG: Mount and unpack"
# mount iso (/mnt/iso)
mkdir /mnt/iso
mount -o loop "${ROOT_PATH}/iso/${IMAGE}.iso" /mnt/iso
# copy file and unmount (/root/extracted_iso)
cp -r /mnt/iso "$EXTRACTED_PATH"
umount /mnt/iso

### Custom iso

echo "LOG: Customise iso"
# extract isohdpfx.bin 
dd if="${ROOT_PATH}/iso/${IMAGE}.iso" bs=512 count=1 of=$EXTRACTED_PATH/isolinux/isohdpfx.bin # (= legacy BIOS compatbility =)

# add custom config
cp $ROOT_PATH/config/isolinux/menu.cfg $EXTRACTED_PATH/isolinux/menu.cfg # (= legacy BIOS compatbility =)
cp $ROOT_PATH/config/boot/grub.cfg $EXTRACTED_PATH/boot/grub/grub.cfg # (= EFI =)
cp $ROOT_PATH/config/preseed.cfg $EXTRACTED_PATH/preseed.cfg

# add custom
mkdir $EXTRACTED_PATH/custom
cp -R $ROOT_PATH/custom/scripts $EXTRACTED_PATH/custom/scripts
mkdir $EXTRACTED_PATH/custom/ssh
cp $ROOT_PATH/custom/ssh/ansible.sudoers $EXTRACTED_PATH/custom/ssh/ansible.sudoers
# fetch ansible_key from root config
cp $ROOT_PATH/../config/ssh/ansible/ansible_key.pub $EXTRACTED_PATH/custom/ssh/ansible_key.pub

# change timeout
chmod +w $EXTRACTED_PATH/isolinux/isolinux.cfg
sed -i "s/timeout 0/timeout 10/g" $EXTRACTED_PATH/isolinux/isolinux.cfg
chmod -w $EXTRACTED_PATH/isolinux/isolinux.cfg
chmod +w $EXTRACTED_PATH/isolinux/prompt.cfg
sed -i "s/timeout 0/timeout 10/g" $EXTRACTED_PATH/isolinux/prompt.cfg
chmod -w $EXTRACTED_PATH/isolinux/prompt.cfg

### repack

echo "LOG: Repack"
# repack iso
# genisoimage -o /root/debian_preseed.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -r /root/extracted_iso
# -isohybrid-mbr (= legacy BIOS compatbility =)
xorriso -as mkisofs \
  -isohybrid-mbr $EXTRACTED_PATH/isolinux/isohdpfx.bin \
  -c isolinux/boot.cat \
  -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot \
  -e boot/grub/efi.img -no-emul-boot -isohybrid-gpt-basdat \
  -o /root/debian_preseed.iso \
  $EXTRACTED_PATH

cp /root/debian_preseed.iso ${ROOT_PATH}/iso/${IMAGE}_preseed.iso

echo "Preseed image written to ${ROOT_PATH}/iso/${IMAGE}_preseed.iso"
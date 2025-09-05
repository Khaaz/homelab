#!/bin/sh

# Prerequesites
get_script_dir() {
	# Get the directory of the currently running script
	local script_dir=$(dirname "$(realpath "$0")")
	echo "$script_dir"
}
SCRIPT_DIR=$(get_script_dir)

ISO="debian-12.9.0-amd64-netinst"
GENERATE_PRESEED_CFG=false
DEV_MODE=
while [ $# -gt 0 ]; do
	case $1 in
		--iso)
			ISO="$2"
			shift 2
			;;
		--preseed-cfg)
			GENERATE_PRESEED_CFG=true
			shift 1
			;;
		--dev)
			DEV_MODE=true
			shift 1
			;;
		*)
			echo "Usage: $0 [--iso <path>] [--preseed-cfg] [--dev]"
			exit 1
			;;
	esac
done

echo "LOG: Start preseed process"

# target ISO
IMAGE=$ISO
# preseed folder
ROOT_PATH="$SCRIPT_DIR/.."
# temporary working folder (extracted iso)
EXTRACTED_PATH="/root/extracted_iso"
# Target volume name (for preseed)
TARGET_VOLUME_NAME="DEBIAN_PRESEED"

echo "LOG: Context - Root path: $ROOT_PATH"
echo "LOG: Context - Build folder: $EXTRACTED_PATH"
echo "LOG: Context - ISO: $ROOT_PATH/iso/$IMAGE.iso"
echo "LOG: Context - Preseeded iso will be: $ROOT_PATH/iso/${IMAGE}_preseed.iso"
echo "LOG: Context - Preseeded iso will have volume named: $TARGET_VOLUME_NAME"

### prerequesites

echo "LOG: Install"
apt-get install -y xorriso

### cleanup

echo "LOG: Cleanup"
chmod +w -R /mnt/iso 2>/dev/null
rm -rf /mnt/iso
rm -rf $EXTRACTED_PATH
umount /mnt/iso 2>/dev/null

### mount

echo "LOG: Mount and unpack"
mkdir -p /mnt/iso
# mount iso (/mnt/iso)
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
# If --generate-preseed-cfg is set, generate and replace preseed.cfg in extracted data
echo "LOG: Copying preseed.cfg"
if [ "$GENERATE_PRESEED_CFG" = true ]; then
	echo "LOG: Generating custom preseed.cfg using generate_preseed_cfg.sh"
	$ROOT_PATH/src/generate_preseed_cfg.sh "$EXTRACTED_PATH/preseed.cfg"
	if [ $? -ne 0 ]; then
		echo "Error: Failed to generate preseed.cfg"
		exit 1
	fi
	cp $EXTRACTED_PATH/preseed.cfg $ROOT_PATH/log/preseed.cfg
else
 	cp $ROOT_PATH/config/preseed.cfg $EXTRACTED_PATH/preseed.cfg
fi

# add custom
mkdir $EXTRACTED_PATH/custom
cp -R $ROOT_PATH/config/custom/scripts $EXTRACTED_PATH/custom/scripts
mkdir $EXTRACTED_PATH/custom/ssh
cp $ROOT_PATH/config/custom/ssh/automation.sudoers $EXTRACTED_PATH/custom/ssh/automation.sudoers
# fetch automation_key from root config
cp $ROOT_PATH/../config/ssh/proxmox/automation_key${DEV_MODE:+.dev}.pub $EXTRACTED_PATH/custom/ssh/automation_key.pub

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
  -V "$TARGET_VOLUME_NAME" \
  -o /root/debian_preseed.iso \
  $EXTRACTED_PATH

cp /root/debian_preseed.iso ${ROOT_PATH}/iso/${IMAGE}_preseed.iso

echo "LOG: End preseed process"
echo "LOG: Preseeded image written to ${ROOT_PATH}/iso/${IMAGE}_preseed.iso"

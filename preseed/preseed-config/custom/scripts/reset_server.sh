#!/bin/bash

# Check if the user provided a disk as an argument
if [ -z "$1" ]; then
	echo "Error: No disk specified. Usage: $0 <disk (/dev/sdX)>"
	exit 1
fi

USB_KEY="$1"  # First argument is the disk

PARTITION="1"    # EFI partition number
LABEL="USB_installer"
LOADER="\EFI\Boot\bootx64.efi"  # Using default loader

# Check for current OS boot entry
OS_BOOT_ENTRY=$(efibootmgr | grep "BootCurrent" | awk '{print $2}')

if [ -z "$OS_BOOT_ENTRY" ]; then
	echo "Error: Could not find OS (debian) boot entry!"
	exit 1
fi
echo "OS (debian) boot entry found: $OS_BOOT_ENTRY"

# Check for existing USB boot entry
EXISTING_USB_BOOT_ENTRY=$(efibootmgr | grep "$LABEL" | awk '{print $1}' | sed 's/Boot//g' | sed 's/\*//g')

if [ ! -z "$EXISTING_USB_BOOT_ENTRY" ]; then
	echo "Removing existing USB boot entry: $EXISTING_USB_BOOT_ENTRY"
	sudo efibootmgr --bootnum "$EXISTING_USB_BOOT_ENTRY" --delete-bootnum
fi

# Create USB boot entry
sudo efibootmgr --create --disk "$USB_KEY" --part "$PARTITION" --loader "$LOADER" --label "$LABEL"

USB_BOOT_ENTRY=$(efibootmgr | grep "$LABEL" | awk '{print $1}' | sed 's/Boot//g' | sed 's/\*//g')

if [ -z "$USB_BOOT_ENTRY" ]; then
	echo "Error: Failed to create USB boot entry!"
	exit 1
fi

echo "New USB boot entry created: $USB_BOOT_ENTRY"

# Reboot on USB boot entry
sudo efibootmgr --bootnext "$USB_ENTRY"
echo "Rebooting now to boot from USB..."
sudo reboot


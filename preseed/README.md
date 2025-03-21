
config/
boot/ => UEFI setup
isolinux/ => Legacy/BIOS mode

in wsl, as root
`./create_preseeded_iso.sh`

with rufus => write the debian_preseed iso on the key
insert key in USB 2.0 port
start the server, it should auto install

TODO:
- check network config? (if we even want to do that)
- check how to "reset" server easily

Remove current authorized key
`ssh-keygen -R 192.168.1.109`

`ssh-keygen -t rsa -b 4096 -f ../config/ssh/ansible/ansible_key`

```
sudo efibootmgr --create --disk "/dev/sda" --part "1" --loader "\EFI\Boot\bootx64.efi" --label "USB_installer"
efibootmgr --bootnext "0000"
sudo reboot
```

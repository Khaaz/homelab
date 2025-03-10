
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

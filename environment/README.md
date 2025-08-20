# Environment

Boot up dev environment

## Dev tools / Setup container

Docker container to run / execute everything needed, used as a rebound server, correctly configured to setup and interact with our proxmox instance

```sh
docker compose run --rm --build environment
```

## VM virtualisation

### Boxes

To create the boxes
virtualbox:
create a template with the preseed iso, skip virtualbox unattended install, check the EFI mode!
change the network configuration, switch adapter1 to bridged with promiscuous mode: allow all
then save and start the VM
Let the installation execute.
Then export the box 
```
vagrant package --base "template" --output boxes/virtualbox.box
```

Vagrant config to boot up a VM quickly to execute and test our proxmox server

```sh
vagrant up --provider virtualbox
vagrant up --provider hyperv

vagrant reload
vagrant destroy
```

----

vagrant or anything else to setup virtual box
docker image with all necessary tooling
tooling install?
helper script to setup default working env

rebound server?

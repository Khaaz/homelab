# ansible


Test env
```
ansible-playbook playbooks/test.playbook.yml
```

Run
```
ansible-playbook playbooks/proxmox-setup.playbook.yml --limit vm-local

ansible-playbook playbooks/proxmox-setup.playbook.yml --limit proxmox-node1
```

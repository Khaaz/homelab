build {
	name = var.proxmox_vm_template_name
	sources = ["source.proxmox-iso.alpine"]

 	# Make sure the system is up before provisioning
	provisioner "shell" {
		inline = ["echo 'Instance up; beginning provisioning'"]
	}

	# Run ansible playbook
	provisioner "ansible" {
		playbook_file = "./ansible/setup.playbook.yml"
		use_proxy = false
	}

	# Reset root password completely
	provisioner "shell" {
		inline = [
			"passwd -d root",
		]
	}
	# Setup cloud init
	provisioner "shell" {
		inline = [
			"setup-cloud-init", 
		]
	}
	# Cleanup
	provisioner "shell" {
		inline = [
			"cloud-init clean || true",
			"rm -rf /var/lib/cloud/* || true",
			"reset machine-id",
			": > /etc/machine-id || true",
			"apk cache clean || true",
			"sync"
		]
	}
}

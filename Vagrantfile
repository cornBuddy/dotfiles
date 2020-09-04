Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vm.box = "archlinux/archlinux"
  config.vm.provision "shell",
    inline: "sudo pacman -Rs --noconfirm virtualbox-guest-utils-nox || true"
  config.vm.provision "shell",
    inline: "sudo pacman -Syy --noconfirm virtualbox-guest-utils"
  config.vbguest.auto_update = false
  config.vbguest.no_remote = true
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "provision.yml"
    ansible.verbose = true
    ansible.limit = "all,localhost"
  end
end

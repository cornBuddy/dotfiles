Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.vm.box = "archlinux/archlinux"
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "provision.yml"
    ansible.verbose = true
    ansible.limit = "all,localhost"
  end
end

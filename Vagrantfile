Vagrant.configure("2") do |config|
  # Identify what box to use.
  box = "trusty64"

  # Set the box.
  config.vm.box = "ubuntu/#{box}"

  # Set the VM provider, plus a memory guarantee.
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 8192
  end

  # Set up port forwarding between the guest and host.
  host_port = ENV["OSUMO_HOST_PORT"] || 8080
  config.vm.network "forwarded_port", guest: 8080, host: host_port

  # Set up shared folders.
  config.vm.synced_folder ".", "/home/vagrant/osumo-ansible"
  config.vm.synced_folder "osumo", "/home/vagrant/osumo-ansible/girder/plugins/osumo"

  # Name the VM.
  config.vm.define "osumo" do |node| end

  # Provision the VM.
  config.vm.provision "ansible" do |ansible|
    ansible.verbose = ""
    ansible.groups = {
      "all" => ["osumo"]
    }

    ansible.playbook = "ansible/#{box}/site.yml"

    Extra_vars = ENV["ANSIBLE_EXTRA_VARS"]
    if !Extra_vars.nil? && !Extra_vars.empty?
      ansible.extra_vars = Hash[Extra_vars.split(/\s+/).map{|w| w.wplit("=")}]
    end
  end
end

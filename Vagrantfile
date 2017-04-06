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
  config.vm.synced_folder "osumo-project/osumo", "/home/vagrant/osumo-ansible/osumo-project/girder/plugins/osumo"

  # Name the VM.
  config.vm.define "osumo" do |node| end

  # Provision the VM.
  config.vm.provision "ansible" do |ansible|
    ansible.verbose = ""
    ansible.groups = {
      "all" => ["osumo"]
    }

    ansible.playbook = "ansible/#{box}/site.yml"

    osumo_anon_user = ENV["OSUMO_ANON_USER"] || ""
    osumo_anon_password = ENV["OSUMO_ANON_PASSWORD"] || ""

    ansible.extra_vars = {
      "osumo_anon_user" => osumo_anon_user,
      "osumo_anon_password" => osumo_anon_password
    }
  end
end

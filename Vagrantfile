
Vagrant.configure(2) do |config|
  config.vm.box = "hashicorp/precise64"

  config.vm.provision :puppet do |puppet|
    puppet.facter = {
      "vmserver" => ENV['VM_SERVER'],
      "ip" => ENV['VM_IP'],
      "slaveip" => ENV['VM_SLAVE_IP'],
      "serverid" => ENV['VM_SERVER_ID'],
    }
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "init.pp"
    puppet.options = '--verbose'
    puppet.module_path = 'modules'
  end
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

  config.vm.define "master-1" do |server|
    config.vm.hostname = ENV['VM_SERVER']
    config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", "1024"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
      end
      config.vm.network :private_network, ip: ENV['VM_IP']
  end
  config.vm.define "master-2"  do |server|
    config.vm.hostname = ENV['VM_SERVER']
    config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", "1024"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
      end
      config.vm.network :private_network, ip: ENV['VM_IP']
  end
  config.vm.define "slave-1" do |server|
    config.vm.hostname = ENV['VM_SERVER']
    config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", "1024"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
      end
      config.vm.network :private_network, ip: ENV['VM_IP']
  end
end

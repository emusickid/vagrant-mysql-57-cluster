
Vagrant.configure(2) do |config|
  config.vm.provision "shell", inline: "/usr/bin/wget -O /tmp/percona-mysql.deb https://repo.percona.com/apt/percona-release_0.1-3.$(lsb_release -sc)_all.deb"
  config.vm.provision "shell", inline: "dpkg -i /tmp/percona-mysql.deb"
  config.vm.provision "shell", inline: "apt-get update"
  config.vm.provision "shell", inline: "/usr/bin/wget -O consul_0.6.4_linux_amd64.zip https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip"
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
    puppet.options = ["--templatedir","/tmp/vagrant-puppet/templates"]
  end
  config.vm.synced_folder "templates", '/tmp/vagrant-puppet/templates'
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

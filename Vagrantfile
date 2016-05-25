 #-*- mode: ruby -*-

# vi: set ft=ruby :

boxes = [
    {
        :hostname => "dc1-master-1",
        :name => "dc1-master-1",
        :eth1 => "192.168.205.10",
        :mem => "1024",
        :cpu => "1"
    },
    {
        :hostname => "dc1-master-2",   
        :name => "dc1-master-2",
        :eth1 => "192.168.205.11",
        :mem => "512",
        :cpu => "1"
    },
    {
        :hostname => "dc1-slave-3",
        :name => "dc1-slave-3",
        :eth1 => "192.168.205.20",
        :mem => "512",
        :cpu => "1"
    },
    # {
    #     :hostname => "dc1-master-1",
    #     :name => "dc2-master-1",
    #     :eth1 => "192.168.205.21",
    #     :mem => "512",
    #     :cpu => "1"
    # },
    # {
    #     :hostname => "dc1-master-2",      
    #     :name => "dc2-master-2",
    #     :eth1 => "192.168.205.22",
    #     :mem => "512",
    #     :cpu => "1"
    # }
]

Vagrant.configure(2) do |config|

  config.vm.box = "hashicorp/precise64"
  config.vm.provider "vmware_fusion" do |v, override|
    override.vm.box = "base"
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "init.pp"
    puppet.options = '--verbose'
    puppet.module_path = 'modules'
  end

  # Turn off shared folders
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

  boxes.each do |opts|
    config.vm.hostname = opts[:hostname]
    config.vm.define opts[:name] do |config|
      #config.vm.hostname = opts[:name]

      config.vm.provider "vmware_fusion" do |v|
        v.vmx["memsize"] = opts[:mem]
        v.vmx["numvcpus"] = opts[:cpu]
      end

      config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", opts[:mem]]
        v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
      end

       config.vm.network :private_network, ip: opts[:eth1]
      # config.vm.network :forwarded_port, guest: 22, host: 5555
    end
  end
end




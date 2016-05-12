 #-*- mode: ruby -*-

# vi: set ft=ruby :

boxes = [
    {
        :name => "dc1-server1",
        :eth1 => "192.168.205.10",
        :mem => "1024",
        :cpu => "1"
    },
    # {
    #     :name => "dc1-server2",
    #     :eth1 => "192.168.205.11",
    #     :mem => "512",
    #     :cpu => "1"
    # },
    # {
    #     :name => "dc1-server3",
    #     :eth1 => "192.168.205.20",
    #     :mem => "512",
    #     :cpu => "1"
    # },
    # {
    #     :name => "dc2-server1",
    #     :eth1 => "192.168.205.21",
    #     :mem => "512",
    #     :cpu => "1"
    # },
    # {
    #     :name => "dc2-server2",
    #     :eth1 => "192.168.205.21",
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
    puppet.manifest_file = "default.pp"
    puppet.options = '--verbose'
  end

  # Turn off shared folders
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

  boxes.each do |opts|
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




Vagrant.configure("2") do |config|
 
    # Number of nodes to provision
    numNodes = 3
 
    # IP Address Base for private network
    ipAddrPrefix = "192.168.33.10"
 
    # Define Number of RAM for each node
    config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", 1024]
    end
 
	# Add the required modules for the EFK Stack 
	config.vm.provision :shell do |shell|
		shell.path = "provisioning/init.sh"
	end
	
    # Provision the server itself with puppet
    #config.vm.provision "puppet" do |puppet|
    #puppet.module_path = "modules"
	
	#end
 
    # Download the initial box from this url
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
 
    # Provision Config for each of the nodes
    1.upto(numNodes) do |num|
        nodeName = ("node" + num.to_s).to_sym
        config.vm.define nodeName do |node|
            node.vm.box = "precise64"
			node.vm.hostname = "ES" + num.to_s
            node.vm.network :private_network, ip: ipAddrPrefix + num.to_s
            node.vm.provider "virtualbox" do |v|
                v.name = "ES Server Node " + num.to_s
            end
        end
    end
 
end
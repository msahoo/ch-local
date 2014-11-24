Vagrant::configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.network "private_network", ip: "192.168.16.100", virtualbox__intnet: "chnetwork"

	config.vm.provider "virtualbox" do |v|
		#v.name = "ch9-local-dev"
		v.memory = 2048
		v.cpus = 2
	end	
	
	#synced folders
	config.vm.synced_folder "/Volumes/mahesh/ch9/sprint/", "/var/www/ch9/", owner: "www-data",group: "www-data",mount_options: ["dmode=775", "fmode=775"]
	
	# Set the timezone to the host timezone
    #require 'time'
    #timezone = 'Etc/GMT' + ((Time.zone_offset(Time.now.zone)/60)/60).to_s
    #config.vm.provision :shell, :inline => "if [ $(grep -c UTC /etc/timezone) -gt 0 ]; then echo \"#{timezone}\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata; fi"


	#config.vm.provision :shell, :inline => "sudo service apache2 restart"

	#port forwarding
	config.vm.network :forwarded_port, host:8080, guest:80
	config.vm.network :forwarded_port, host:8081, guest:81
	config.vm.network :forwarded_port, host:11212, guest:11211
	#config.vm.network :forwarded_port, host:9000, guest:9000 

	#provision
	config.vm.provision :puppet do |puppet|
		 puppet.manifests_path = "manifests"
		 puppet.manifest_file  = "apache.pp"
		 puppet.options="--verbose --debug"
	end
		
	config.vm.provision :puppet do |puppet|
		 puppet.manifests_path = "manifests"
		 puppet.manifest_file  = "php.pp"
		 puppet.options="--verbose --debug"
	end

	config.vm.provision :puppet do |puppet|
		 puppet.manifests_path = "manifests"
		 puppet.manifest_file  = "memcache.pp"
		 puppet.options="--verbose --debug"
	end

	config.vm.provision :puppet do |puppet|
		 puppet.manifests_path = "manifests"
		 puppet.manifest_file  = "varnish.pp"
		 puppet.options="--verbose --debug"
	end

	config.vm.provision "shell", inline: "sudo apt-get install -y php5-mysqlnd", run: "always"

	config.vm.provision "shell", inline: "sudo service apache2 restart", run: "always"

end

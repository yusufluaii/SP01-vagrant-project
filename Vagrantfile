Vagrant.configure("2") do |config|


config.vm.define "landingpage" do |landingpage|
    landingpage.vm.box =  'ubuntu/xenial64'
    landingpage.vm.provision "shell", path: "landingPage.sh"
    landingpage.vm.network "private_network", ip: "192.168.100.5"
  end

  config.vm.define "wordpress" do |wordpress|
    wordpress.vm.box = "ubuntu/xenial64"
    wordpress.vm.provision "shell", path: "wordpress.sh"
    wordpress.vm.network "private_network", ip: "192.168.100.6"

  end

  config.vm.define "sosmed" do |sosmed|
    sosmed.vm.box = "ubuntu/xenial64"
    sosmed.vm.provision "shell", path: "sosialMedia.sh"
    sosmed.vm.network "private_network", ip: "192.168.100.7"

  end

end

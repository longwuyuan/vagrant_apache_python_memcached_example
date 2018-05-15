VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "infrac/devops-test-vm"

  config.vm.network :forwarded_port, guest: 80, host: 8080    # Apache HTTP
  config.vm.network :forwarded_port, guest: 443, host: 8443   # Apache HTTPS
  config.vm.network :forwarded_port, guest: 5000, host: 5000  # Flask debug server

  config.vm.provision "file", source: "files/000-default.conf", destination: "/tmp/000-default.conf"
  config.vm.provision "file", source: "files/default-ssl.conf", destination: "/tmp/default-ssl.conf"
  config.vm.provision "file", source: "app/app.py", destination: "/tmp/app.py"
  config.vm.provision "file", source: "app/app.wsgi", destination: "/tmp/app.wsgi"
  config.vm.provision "file", source: "app/templates/app.html.j2", destination: "/tmp/app.html.j2"
  config.vm.provision "shell", path: "files/provision.sh"

  # config.vm.synced_folder "#{ENV['HOME']}/devops-test-share", "/var/www/devops-test-share"

end

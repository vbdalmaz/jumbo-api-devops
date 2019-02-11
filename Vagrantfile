Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox"
  config.vm.provider "aws"

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ""
    aws.secret_access_key = ""
    aws.keypair_name = "jumbodalmaz"
    aws.ami = "ami-03c6239555bb12112"
    aws.region = "sa-east-1"
    aws.instance_type = "t2.micro"
    aws.security_groups = ['meli-dalmaz']
    override.vm.box = "dummy"
    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "jumbodalmaz.pem"
  end

  #novo ambiente aws_web, agora com puppet
  config.vm.define :aws_web do |aws_web_config|

    aws_web_config.vm.box = "dummy"
    aws_web_config.vm.synced_folder '.', '/vagrant', type: "rsync"

    aws_web_config.vm.provider :aws do |aws|
    	aws.tags = { 'Name' => 'Jumbo(vagrant)'}
    end

    ## shell e puppet provisioner
    aws_web_config.vm.provision "shell", path: "manifests/bootstrap.sh"
    aws_web_config.vm.provision "puppet" do |puppet|
       puppet.manifest_file = "web.pp"
       puppet.synced_folder_type = 'rsync'
    end
  end

  config.vm.define :web do |web_config|
    #usando ubuntu 18.04
    web_config.vm.box = "ubuntu/bionic64"
    web_config.vm.network "private_network", ip: "192.168.50.10"
    web_config.vm.provision "shell", path: "manifests/bootstrap.sh"
    web_config.vm.provision "puppet" do |puppet|
      puppet.manifest_file = "web.pp"
    end
  end

end

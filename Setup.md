# How to setup a vagrant box and other stuff to dev on PL stuff

1. `vagrant init ubuntu/trusty64`
2. Add `config.vm.synced_folder "/path/to/home/on/host/machine/experiments/experiments-in-vm", "/home/vagrant/experiments"` to `Vagrantfile`
3. `touch bootstrap.sh` in folder that contains `Vagrantfile`
4. Add the following to `bootstrap.sh`
   ```bash
   #!/usr/bin/env bash

   apt-get update
   apt-get install -y llvm clang htop flex bison git git-svn
   ```
5. Add `config.vm.provision :shell, path: "bootstrap.sh"` to `Vagrantfile`
6. `vagrant up`
7. `vagrant ssh`

# Vagrant-PHP-Stack

A kick-ass Vagrant Stack for PHP developer.


## Installation

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://vagrantup.com)
* [Chef Development Kit](http://www.getchef.com)
  * Download ChefDK from here: `http://getchef.com/downloads/chef-dk`
* [Berkshelf](http://berkshelf.com)
  * `gem install berkshelf`
* [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier)
  * `vagrant plugin install vagrant-cachier`
* [vagrant-berkshelf](https://github.com/riotgames/vagrant-berkshelf)
  * `vagrant plugin install vagrant-berkshelf`
* [vagrant-hostmanager](https://github.com/smdahlen/vagrant-hostmanager)
  * `vagrant plugin install vagrant-hostmanager`
* [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus)
  * `vagrant plugin install vagrant-omnibus`


## Quick start

## FAQ

### I got this error: `RuntimeError: Couldn't determine Berks version` ###

* try to run `export PATH='/opt/chefdk/bin:'$PATH` and add it in your .bashrc/.zshrc file , then run again.

### I got this error: `Operation timed out - connect(2) for "s3.amazonaws.com" port 443 (Errno::ETIMEDOUT)` ###

* It's becasue that your network connection to Amazon S3 is poor, try to use vpn or use a fixed ip for s3.amazonaws.com in hosts file.

### I'm stuck at retrieving box file,what should I do? ###

* download box file by thunder or somthingelse, the url will be `https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/1/providers/virtualbox.box`
* use the command to add the box locally `vagrant box add "ubuntu/trusty64" /path/to/virtualbox.box`

### I'm stuck at retrieving the chef****.deb (for example chef_11.16.4-1_amd64.deb) file at amazone s3,you can do somthing like this: ###

* download the file from anywhere else (for example by thunder)
* put it into ~/.vagrant.d/cache/ubuntu/trusty64/vagrant_omnibus
* done.

### I got this error : ERROR: You must specify at least one cookbook repo path ###

* try to `vagrant reload --provision`
* If it's not working, delete your `~/.vagrant.d` folder and try `vagrant reload --provision` again.

### Root Privilege Requirement (refs: http://docs.vagrantup.com/v2/synced-folders/nfs.html) ###

To configure NFS, Vagrant must modify system files on the host. Therefore, at some point during the vagrant up sequence, you may be prompted for administrative privileges (via the typical sudo program). These privileges are used to modify /etc/exports as well as to start and stop the NFS server daemon.

If you don't want to type your password on every vagrant up, Vagrant uses thoughtfully crafted commands to make fine-grained sudoers modifications possible to avoid entering your password.

Below, we have a couple example sudoers entries. Note that you may have to modify them slightly on certain hosts because the way Vagrant modifies /etc/exports changes a bit from OS to OS.

For OS X, sudoers should have this entry:

```
Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
Cmnd_Alias VAGRANT_NFSD = /sbin/nfsd restart
Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /usr/bin/sed -E -e /*/ d -ibak /etc/exports
%admin ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE
```

For Linux, sudoers should look like this:

```
Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
Cmnd_Alias VAGRANT_NFSD_CHECK = /etc/init.d/nfs-kernel-server status
Cmnd_Alias VAGRANT_NFSD_START = /etc/init.d/nfs-kernel-server start
Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /bin/sed -r -e * d -ibak /etc/exports
%sudo ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY, VAGRANT_EXPORTS_REMOVE
```

## Contributing

not one yet, pr is welcome !

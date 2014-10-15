# Vagrant-PHP-Stack

A kick-ass Vagrant Stack for PHP developer.


## Installation

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://vagrantup.com)
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

I'm stuck at retrieving the chef****.deb (for example chef_11.16.4-1_amd64.deb) file at amazone s3,you can do somthing like this:

* download the file from anywhere else (for example by thunder)
* put it into ~/.vagrant.d/cache/ubuntu/trusty64/vagrant_omnibus
* done.

I got this error : ERROR: You must specify at least one cookbook repo path

* try to `vagrant reload --provision`
* If it's not working, delete your `~/.vagrant.d` folder and try `vagrant reload --provision` again.

## Contributing



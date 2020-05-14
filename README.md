
# DevOps box
* A vagrant project with an ubuntu box with the tools needed to do DevOps

# Usage
1. Install
```
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-librarian-chef-nochef
vagrant plugin install vagrant-winnfsd

git config --global core.autocrlf false
git config --global core.eol lf
git clone https://github.com/finfra/prometheus_quickstart.git
cd prometheus_quickstart
vagrant destroy -f ;vagrant up;vagrant status
```
2. Test
```
open http://172.17.8.5:9090
scrape_samples_scraped → Execute → graph
```

3. Check
```
./check.sh
```


# prerequisite
* VirtualBox : https://www.virtualbox.org/wiki/Downloads
* Vagrant : https://www.vagrantup.com/downloads.html

# References
* https://github.com/in4it/prometheus-course

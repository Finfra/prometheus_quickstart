
# DevOps box
* A vagrant project with an ubuntu box with the tools needed to do DevOps

# Usage
1. install
```
git clone https://github.com/finfra/prometheus_quickstart.git
cd prometheus_quickstart
vagrant destroy -f ;vagrant up;vagrant ssh
```
2. test
```
open http://172.17.8.100:9090
scrape_samples_scraped → Execute → graph
```



# prerequisite
* VirtualBox : https://www.virtualbox.org/wiki/Downloads
* Vagrant : https://www.vagrantup.com/downloads.html

# References
* https://github.com/in4it/prometheus-course

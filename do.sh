vagrant ssh p1 -c'touch /vagrant'
vagrant ssh p1 -c'touch /vagrant/VagrantShareFolderOK'
ls |grep VagrantShareFolderOK
rm VagrantShareFolderOK


#!/bin/bash

ls



echo -p1--vagrant Prometheus check----------------------------------------------
curl http://172.17.8.5:9090|head -n 3
x=$(which open)
if [ ${#x} -eq 0 ]; then
  start http://172.17.8.5:9090
else
  open http://172.17.8.5:9090
fi

echo ---------------------------------------------------------------------------


echo -s1----vagrant share folder check------------------------------------------
vagrant ssh s1 -c'touch /vagrant'
vagrant ssh s1 -c'touch /vagrant/VagrantShareFolderOK'
ls |grep VagrantShareFolderOK
rm VagrantShareFolderOK
echo ---------------------------------------------------------------------------

echo -s2----vagrant share folder check------------------------------------------
vagrant ssh s2 -c'systemctl  --no-pager status grafana-server'
curl http://172.17.8.12:3000|head -n 3
x=$(which open)
if [ ${#x} -eq 0 ]; then
  start http://172.17.8.12:3000
else
  open http://172.17.8.12:3000
fi

echo ---------------------------------------------------------------------------

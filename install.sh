#!/bin/bash

# Nameserver Setting
# echo "nameserver 8.8.8.8">>/etc/resolv.conf


# Install package
locale-gen ko_KR.UTF-8
export LC_ALL=C.UTF-8
export DEBIAN_FRONTEND=noninteractive
echo "export LC_ALL=C.UTF-8">>/etc/bash.bashrc
echo "export DEBIAN_FRONTEND=noninteractive">>/etc/bash.bashrc

apt -y update && apt -y upgrade
apt -y install tree
apt -y install git-core tree

apt -y install software-properties-common

add-apt-repository -y ppa:deadsnakes/ppa
sleep 5
apt -y install python3
apt -y install python3-pip


python3 -m pip install --user --upgrade pip

# apt install -y wget systemd
sleep 5

# Prometheus node
if [[ $1 -eq 1 ]]; then
    echo "p$1 vm is intstalling..............................."
    # Prometheus Download
    #PROMETHEUS_VERSION="2.13.1"
    PROMETHEUS_VERSION="2.18.0"
    cd /vagrant/forVm/
    [ ! -f prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz ] && wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
    tar -xzvf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
    cd prometheus-${PROMETHEUS_VERSION}.linux-amd64/
    # if you just want to start prometheus as root
    #./prometheus --config.file=prometheus.yml

    # create user
    useradd --no-create-home --shell /bin/false prometheus

    # create directories
    mkdir -p /etc/prometheus
    mkdir -p /var/lib/prometheus

    # set ownership
    chown prometheus:prometheus /etc/prometheus
    chown prometheus:prometheus /var/lib/prometheus

    # copy binaries
    cp prometheus /usr/local/bin/
    cp promtool /usr/local/bin/

    chown prometheus:prometheus /usr/local/bin/prometheus
    chown prometheus:prometheus /usr/local/bin/promtool

    # copy config
    cp -r consoles /etc/prometheus
    cp -r console_libraries /etc/prometheus
    cp prometheus.yml /etc/prometheus/prometheus.yml

    chown -R prometheus:prometheus /etc/prometheus/consoles
    chown -R prometheus:prometheus /etc/prometheus/console_libraries

    # setup systemd
    echo '[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/prometheus.service

    systemctl daemon-reload
    systemctl enable prometheus
    systemctl start prometheus


    # for Source Code
    python3 -m pip install --upgrade pip
    python3 -m pip install flask
    [ ! -d /vagrant/forVm/prometheus-course ] && git clone https://github.com/Finfra/prometheus-course.git /vagrant/forVm/prometheus-course
    [ ! -d /vagrant/forVm/client_python ] && git clone https://github.com/prometheus/client_python /vagrant/forVm/client_python
    echo "p$1 vm is intstalled................................"
fi


# Servers to be monitored
if [[ $1 -gt 1 ]]; then
    echo "s$1 vm is intstalling..............................."
    python3 -m pip install prometheus_client
    echo "s$1 vm is intstalled................................"
fi


# Grafana node
if [[ $1 -eq 3 ]]; then
    echo "s$1(Grafana node) vm is intstalling..............................."
    echo 'deb https://packages.grafana.com/oss/deb stable main' >> /etc/apt/sources.list
    curl https://packages.grafana.com/gpg.key | sudo apt-key add -
    sudo apt-get update
    sudo apt-get -y install grafana

    systemctl daemon-reload
    systemctl start grafana-server
    systemctl enable grafana-server.service
    echo "s$1(Grafana node) vm is intstalled................................"
fi

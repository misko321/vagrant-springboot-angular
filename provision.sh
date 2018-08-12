#!/bin/sh

add-apt-repository ppa:git-core/ppa

add-apt-repository ppa:webupd8team/java
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

apt-get update
apt-get install -y \
	build-essential \
	git \
	oracle-java8-installer \
	nodejs \
	maven

echo "PATH=\$PATH:/home/vagrant/spring-boot-cli/bin/" >> .profile
cp /home/vagrant/spring-boot-cli/shell-completion/bash/* /etc/bash_completion.d/


npm install -g @angular/cli

// TODO mount in some specific directory
// TODO mvn clean install
// TODO docker
// TODO ansible

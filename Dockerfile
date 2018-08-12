FROM phusion/baseimage:0.10.1
MAINTAINER Michał Patron "michal.patron@gmail.com"

# https://github.com/mitchellh/vagrant/blob/master/keys/vagrant.pub
# Enough for development, it gets replaced by random vagrant generated key @ vagrant up
ENV VAGRANT_INSECURE_SSH_KEY ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key

# Enable SSH
RUN rm -f /etc/service/sshd/down
RUN mkdir -p /var/run/sshd && chmod 0755 /var/run/sshd
EXPOSE 22

# Install sudo
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y sudo

# Create vagrant user
RUN useradd -m -s /bin/bash vagrant

# Configure SSH access
RUN mkdir -p /home/vagrant/.ssh
RUN echo "$VAGRANT_INSECURE_SSH_KEY" > /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant: /home/vagrant/.ssh
RUN echo -n 'vagrant:vagrant' | chpasswd

# Enable passwordless sudo for the "vagrant" user
RUN mkdir -p /etc/sudoers.d
RUN install -m 0440 /dev/null /etc/sudoers.d/vagrant
RUN echo 'vagrant ALL=NOPASSWD: ALL' >> /etc/sudoers.d/vagrant

# Clean up APT when everything's done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# TODO zsh, fzf, z

#!/bin/bash
 
# Install HTTPD service needed for the local YUM repo
yum -y install httpd wget
service httpd start

# Prepare a folder to copy the installation tarballs
mkdir /staging
chmod -R a+rx /staging 

# Copy installation tarballs
tar -xvzf /vagrant/packages/AMBARI-1.7.1-87-centos6.tar -C /staging/
tar -xvzf /vagrant/packages/PHD-3.0.0.0-249-centos6.tar -C /staging/
tar -xvzf /vagrant/packages/PHD-UTILS-1.1.0.20-centos6.tar -C /staging/
tar -xvzf /vagrant/packages/PADS-1.3.0.2-14421-rhel5_x86_64.tar.gz -C /staging/
tar -xvzf /vagrant/packages/hawq-plugin-phd-1.2-99.tar.gz -C /staging/

# Setup YUM repositories for the installation packages
/staging/AMBARI-1.7.1/setup_repo.sh 
/staging/PHD-3.0.0.0/setup_repo.sh 
/staging/PHD-UTILS-1.1.0.20/setup_repo.sh 
/staging/PADS-1.3.0.2/setup_repo.sh  
/staging/hawq-plugin-phd-1.2-99/setup_repo.sh 

# yum --enablerepo=hawq-plugin-phd-1.0-57 clean metadata

# Install the Ambari Server
yum -y install ambari-server

# Install the HAWQ Ambari plugin
yum -y install /staging/hawq-plugin-phd-1.2-99/hawq-plugin-1.2-99.noarch.rpm

wget -nv http://repo.spring.io/yum-release/spring-xd/1.2/spring-xd-1.2.repo -O /etc/yum.repos.d/spring-xd-1.2.repo
yum -y install spring-xd-plugin-phd

# Install JDK7 and Policty file
cp /vagrant/packages/jdk-7u67-linux-x64.tar.gz /var/lib/ambari-server/resources/
cp /vagrant/packages/UnlimitedJCEPolicyJDK7.zip /var/lib/ambari-server/resources/

# Set nagios credentials nagiosadmin/admin
htpasswd -c -b  /etc/nagios/htpasswd.users nagiosadmin admin

# Configure and start the Ambari Server
ambari-server setup -s
ambari-server start

# Add SSH passwordless keys
cp /vagrant/id_dsa.pub /home/vagrant/.ssh/
cp /vagrant/id_dsa /home/vagrant/.ssh/
chown vagrant:vagrant /home/vagrant/.ssh/id_dsa*
chmod 400 /home/vagrant/.ssh/id_dsa
cat /vagrant/id_dsa.pub | cat >> ~/.ssh/authorized_keys

# Install python-pip and python's 'requests' modules (Needed by the SetRepos script)
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm      
yum -y install python-pip
pip install requests

# Register the YUM repos with Ambari 
# (Script is shamelessly borrowed from the Pivotal AWS project)
python /vagrant/provision/SetRepos.py

# Install and configure Redis server. Used for SpringXD transport
yum -y install redis
chkconfig redis on
sudo sed -i "s/bind 127.0.0.1/#bind 127.0.0.1/g;" /etc/redis.conf
service redis start


#Install local Ambari Agent
yum install -y ambari-agent
sudo ambari-agent start

# Useful comments
# http://ambari.localdomain/AMBARI-1.7.1
# http://ambari.localdomain/PHD-3.0.0.0
# http://ambari.localdomain/PHD-UTILS-1.1.0.20
# http://ambari.localdomain/PADS-1.3.0.0

# java -jar /vagrant/ambari-shell-0.1.DEV.jar --ambari.server=localhost --ambari.port=8080 --ambari.user=admin --ambari.password=admin
# curl -u admin:admin -H "X-Requested-By: ambari" -X DELETE  http://localhost:8080/api/v1/clusters/cluster1/services/HAWQ
# curl -u admin:admin -H "X-Requested-By: ambari" -X DELETE  http://localhost:8080/api/v1/clusters/cluster1/services/PXF
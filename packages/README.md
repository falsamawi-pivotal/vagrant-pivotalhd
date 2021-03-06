# Packages
This folder keeps the packages and tarballs to be installed. For legal reasons we can not distribute those packages directly but you can follow the instructions bellow to collect them. 

Supported stacks (`PHD3.0` and `HDP2.2`) have common pakcages (like JDK7 and UnlimitedJCEPolicyJDK7) and specific tarballs. Follow the sections below to download the packages for the rquired stack. It is safe to download packages for both stacks it the same `packages` folder. 

#### Packages common for all blueprint stacks

###### JDK-7u67 and UnlimitedJCEPolicyJDK7.zip
Execute this command to download Oracle's jdk-7u67-linux-x64.tar.gz:
```
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz"
```
*Note*: The name of the Java JDK tarball is hardcoded in the Ambari setup script to jdk-7u67-linux-x64.tar.gz, which means you need to download the exact same version from Oracle.

Execute this command to download  UnlimitedJCEPolicyJDK7.zip in the packages directory:
```
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/7/UnlimitedJCEPolicyJDK7.zip"
```
###### SpringXD 1.2
Nothing to do. The [SpringXD](http://projects.spring.io/spring-xd/) external YUM repository is installed authomatically according to [Installing Spring XD using Ambari](https://github.com/spring-projects/spring-xd-ambari/blob/master/src/docs/asciidoc/InstallingXDwithAmbari.asciidoc).

#### PHD 3.0 Stack Packages

###### Ambari-1.7 and PivotalHD-3.0
From https://network.pivotal.io/products/pivotal-hd#/releases/3-0 download the Ambary and PHD3.0 tarballs:
* Pivotal Ambari 1.7.1 (RHEL, CentOS)
* Pivotal HD 3.0 (RHEL, CentOS)
* PHD Utils 1.1.0.20 (RHEL, CentOS)

###### HAWQ 1.3
From https://network.pivotal.io/products/pivotal-hawq#/releases/272/file_groups/279 download the fallowing HAWQ tarballs:
* Pivotal HAWQ Ambari Plugin 1.2 - PHD 3.0
* Pivotal HAWQ 1.3.0.3 (RHEL, CentOS) (r14932)

Finally the packages folder should those tarballs:
* jdk-7u67-linux-x64.tar.gz
* UnlimitedJCEPolicyJDK7.zip
* AMBARI-1.7.1-87-centos6.tar
* PHD-3.0.0.0-249-centos6.tar
* PHD-UTILS-1.1.0.20-centos6.tar
* PADS-1.3.0.3-14932-rhel5_x86_64.tar.gz
* hawq-plugin-phd-1.2-99.tar.gz

#### HDP 2.2 Stack Packages
###### HAWQ 1.3
From https://network.pivotal.io/products/pivotal-hawq#/releases/272/file_groups/279 download the fallowing HAWQ tarballs:
* Pivotal HAWQ Ambari Plugin 1.2 - HDP 2.2.4.2
* Pivotal HAWQ 1.3.0.3 (RHEL, CentOS) (r14932)
 
You packages folder should contain those tarballs:
* jdk-7u67-linux-x64.tar.gz
* UnlimitedJCEPolicyJDK7.zip
* PADS-1.3.0.3-14932-rhel5_x86_64.tar.gz
* hawq-plugin-hdp-1.2-133.tar.gz


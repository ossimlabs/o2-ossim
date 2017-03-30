FROM project.ext.baseImage:release
MAINTAINER DigitalGlobe-RadiantBlue
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm java-1.8.0-openjdk haveged unzip && yum clean all
ADD epel.repo /etc/yum.repos.d/epel.repo
ADD ossim-master.repo /etc/yum.repos.d/ossim.repo

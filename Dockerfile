ARG BASE_IMAGE
FROM ${BASE_IMAGE}
USER root
ENV OSSIM_PREFS-FILE=/usr/share/ossim/ossim-site-preferences \
    OSSIM_INSTALL_PREFIX=/usr \
    OSSIM_DATA=/data
ADD ossim.repo /etc/yum.repos.d/
RUN yum -y install nss_wrapper gettext fuse curl jsoncpp ossim ossim-kakadu-plugin \
ossim-web-plugin ossim-jpeg12-plugin ossim-sqlite-plugin \
ossim-geopdf-plugin ossim-png-plugin ossim-gdal-plugin ossim-atp-plugin \
ossim-aws-plugin && yum clean all
USER 1001

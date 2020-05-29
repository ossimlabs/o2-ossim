FROM nexus-docker-public-hosted.ossim.io/openjdk8:alpine-slim

USER root
ENV OSSIM_PREFS_FILE=/usr/local/share/ossim/ossim-site-preferences \
    OSSIM_INSTALL_PREFIX=/usr/local \
    OSSIM_DATA=/data \
    PATH=/usr/local/bin:/usr/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:$PATH
ADD ./ossim-sandbox-centos-7-runtime.tgz /usr/local/
USER 1001
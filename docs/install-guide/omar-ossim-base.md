# OMAR OSSIM Base

## Dockerfile
```
FROM omar-base
RUN \
   yum -y install ossim && \
   yum -y install ossim-kakadu-plugin && \
   yum -y install ossim-jpeg12-plugin && \
   yum -y install ossim-sqlite-plugin && \
   yum -y install ossim-geopdf-plugin && \
   yum -y install ossim-png-plugin && \
   yum -y install ossim-gdal-plugin.x86_64 && \
   yum clean all
```
Ref: [omar-base](../../../omar-base/docs/install-guide/omar-base/)

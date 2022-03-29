FROM centos:latest

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum -y update && \
    yum -y upgrade && \
    yum -y install httpd && \
    yum -y install nano && \
    yum clean all
EXPOSE 80
# Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh ./run-httpd.sh
RUN chmod -v +x /run-httpd.sh
CMD ["/run-httpd.sh"]

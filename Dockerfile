FROM centos:7

USER 0
RUN yum -y install httpd
RUN yum -y clean all
RUN sed -i 's/Listen 80/Listen 8080' /etc/httpd/conf/httpd.conf
RUN chown -R a+rwx /run/httpd /var/log/httpd
EXPOSE 8080

USER nobody
CMD /usr/sbin/httpd -DFOREGROUND



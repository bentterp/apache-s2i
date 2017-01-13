FROM openshift/base-centos7
MAINTAINER bent.terp@basefarm.com

LABEL io.k8s.description="Platform for serving static HTML files" \
      io.k8s.display-name="Apache HTTPD 2.4" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,html,httpd"
      
USER 0
RUN yum -y install httpd
RUN yum -y clean all
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf
RUN echo 'ServerName localhost.localdomain:8080' >> /etc/httpd/conf/httpd.conf
RUN chmod -R a+rwx /run/httpd /var/log/httpd /var/www/html
EXPOSE 8080
COPY ./s2i/ ${STI_SCRIPTS_PATH}
RUN chmod -R a=rx ${STI_SCRIPTS_PATH}
USER 10001
CMD ${STI_SCRIPTS}/usage



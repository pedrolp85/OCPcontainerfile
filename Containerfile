FROM registry.access.redhat.com/ubi8/ubi

USER root

LABEL maintainer="John Doe" version="1.0" description="this is Containerfile"

# DocumentRoot for Apache
ENV DOCROOT=/var/www/html

RUN yum install -y --nodocs --disableplugin=subscription-manager httpd && \
 yum clean all --disableplugin=subscription-manager -y 
 
EXPOSE 80

# This stuff is needed to ensure a clean start

RUN mkdir -p /var/www/html && \
    echo "Hello from the httpd-parent container!" > ${DOCROOT}/index.html && \
    rm -rf /run/httpd  && \
    mkdir /run/httpd 

ONBUILD COPY src /var/www/html

# Launch httpd

CMD /usr/sbin/httpd -DFOREGROUND

FROM quay.io/packet/baseimage
MAINTAINER Sam Tresler "quay@packethost.net"

USER root

ENV HOME /home/packet
ENV GH_ROOT $HOME/github
ENV DOCROOT /var/www/html

# Copy our build context to a temporary location.
ADD ./ $GH_ROOT
WORKDIR $GH_ROOT

RUN \ 
  apt-get update -q && \
  apt-get install -qy apache2 && \
  rsync -av --exclude-from docker/config/excludes.txt $GH_ROOT/ $DOCROOT/ && \
  rm $DOCROOT/index.html

EXPOSE 80  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
 

  


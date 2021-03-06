FROM ubuntu:latest
MAINTAINER Yujie Ge <yjgai@mathildetech.com>

#Install packages
RUN apt-get update && DEBIAN_FRONTED=noninteractive apt-get -y install openssh-server pwgen nginx
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh


ADD sites-enabled/ /etc/nginx/sites-enabled/

ENV AUTHORIZED_KEYS **None**

EXPOSE 22 80
CMD ["/run.sh"]
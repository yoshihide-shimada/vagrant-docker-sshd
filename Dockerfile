FROM yoshi3/centos:latest
MAINTAINER Yoshihide Shimada <y_shimada@pal-style.co.jp>

# initialize
RUN yum -y update

# supervisor
RUN yum install -y python-setuptools
RUN easy_install supervisor
COPY docker.d/supervisord.sh /etc/init.d/supervisord
RUN chmod 755 /etc/init.d/supervisord

# install ssh
RUN yum -y install openssh-server openssh-clients sudo
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# create ssh user ID:admin PW:admin
RUN useradd -d /home/admin -m -s /bin/bash admin
RUN echo admin:admin | chpasswd
RUN echo 'admin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN sed -i -e 's/^\(Defaults    secure_path.*\)/#\1/' /etc/sudoers
RUN echo 'Defaults env_keep += "PATH"' >> /etc/sudoers
RUN /usr/bin/ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -C '' -N ''
RUN /usr/bin/ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N ''

EXPOSE 22

# copy Dockerfile into this image for just in case.
COPY Dockerfile /home/admin/Dockerfle

COPY docker.d/supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
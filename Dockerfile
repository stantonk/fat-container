FROM ubuntu-upstart:14.04

RUN apt-get update && apt-get install -y software-properties-common

#borrowed this bit from opentable/baseimage-java8
# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# **you should never do this in production**
# want sshd running for testing mendel
# set root password
RUN echo 'root:silly' | chpasswd

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# make this work like it's a vagrant box
# mendel is designed to assume local deployments are vagrant deployments
RUN adduser vagrant
RUN adduser --home /srv/myservice --system --disabled-password --group myservice
RUN echo 'vagrant:vagrant' | chpasswd
RUN usermod -aG sudo vagrant

# replicate sprout_java LWRP
RUN adduser --home /srv/myservice --system --disabled-password --group myservice
ADD ./myservice.conf /etc/init/myservice.conf
RUN mkdir /srv/myservice/releases
RUN mkdir /srv/myservice/releases/init
RUN ln -sfT /srv/myservice/releases/init /srv/myservice/current
RUN chown -R myservice:myservice /srv/myservice

# expose port for myservice
EXPOSE 8080

CMD ["/sbin/init"]

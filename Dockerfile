FROM ubuntu:xenial
LABEL maintainer="Betacloud Solutions GmbH (https://www.betacloud-solutions.de)"

ARG VERSION
ENV VRSION ${VERSION:-1.0.1}

ENV DEBIAN_FRONTEND noninteractive

# Add Aptly repository
RUN echo "deb http://repo.aptly.info/ squeeze main" > /etc/apt/sources.list.d/aptly.list
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 9E3E53F19C7DE460

# Add Nginx repository
RUN echo "deb http://nginx.org/packages/ubuntu/ xenial nginx" > /etc/apt/sources.list.d/nginx.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ xenial nginx" >> /etc/apt/sources.list.d/nginx.list
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62

# Update APT repository and install packages
RUN apt-get update \
   && apt-get -y install \
       aptly \
       bash-completion \
       bzip2 \
       curl \
       gnupg \
       gpgv \
       graphviz \
       lsb-release \
       nginx \
       supervisor \
       wget \
       xz-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Aptly Configuration
COPY files/aptly.conf /etc/aptly.conf

# Enable Aptly Bash completions
RUN wget https://github.com/smira/aptly/raw/master/bash_completion.d/aptly \
  -O /etc/bash_completion.d/aptly \
  && echo "if ! shopt -oq posix; then\n\
  if [ -f /usr/share/bash-completion/bash_completion ]; then\n\
    . /usr/share/bash-completion/bash_completion\n\
  elif [ -f /etc/bash_completion ]; then\n\
    . /etc/bash_completion\n\
  fi\n\
fi" >> /etc/bash.bashrc

# Install Nginx Config
COPY files/nginx.conf.sh /opt/nginx.conf.sh
COPY files/supervisord.nginx.conf /etc/supervisor/conf.d/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Install scripts
COPY files/*.sh /opt/

# Bind mount location
VOLUME ["/opt/aptly"]

# Execute Startup script when container starts
ENTRYPOINT ["/opt/startup.sh"]

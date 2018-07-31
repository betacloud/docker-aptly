FROM ubuntu:xenial
LABEL maintainer="Betacloud Solutions GmbH (https://www.betacloud-solutions.de)"

ARG VERSION
ENV VRSION ${VERSION:-1.3.0}

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://repo.aptly.info/ squeeze main" > /etc/apt/sources.list.d/aptly.list \
   && apt-key adv --keyserver keys.gnupg.net --recv-keys 9E3E53F19C7DE460 \
   && echo "deb http://nginx.org/packages/ubuntu/ xenial nginx" > /etc/apt/sources.list.d/nginx.list \
   && apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
   && apt-get update \
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
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && wget https://github.com/smira/aptly/raw/master/bash_completion.d/aptly \
  -O /etc/bash_completion.d/aptly \
  && echo "if ! shopt -oq posix; then\n\
  if [ -f /usr/share/bash-completion/bash_completion ]; then\n\
    . /usr/share/bash-completion/bash_completion\n\
  elif [ -f /etc/bash_completion ]; then\n\
    . /etc/bash_completion\n\
  fi\n\
fi" >> /etc/bash.bashrc \
    && echo "daemon off;" >> /etc/nginx/nginx.conf \
    && curl -sSL https://repository-1.osism.io/aptly.pub | gpg --import --no-default-keyring --keyring trustedkeys.gpg -

COPY files/aptly.conf /etc/aptly.conf
COPY files/nginx.conf.sh /opt/nginx.conf.sh
COPY files/supervisord.nginx.conf /etc/supervisor/conf.d/nginx.conf
COPY files/*.sh /opt/

# Bind mount location
VOLUME ["/opt/aptly"]

# Execute Startup script when container starts
ENTRYPOINT ["/opt/startup.sh"]

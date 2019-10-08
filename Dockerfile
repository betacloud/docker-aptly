FROM ubuntu:18.04
LABEL maintainer="Betacloud Solutions GmbH (https://www.betacloud-solutions.de)"

ARG VERSION
ENV VRSION ${VERSION:-1.4.0}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
   && apt-get -y install \
       gnupg \
       gpgv \
   && echo "deb http://repo.aptly.info/ squeeze main" > /etc/apt/sources.list.d/aptly.list \
   && apt-key adv --keyserver pool.sks-keyservers.net --recv-keys ED75B5A4483DA07C \
   && apt-get update \
   && apt-get -y install \
       aptly=$VERSION \
       bash-completion \
       bzip2 \
       curl \
       graphviz \
       lsb-release \
       wget \
       xz-utils \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && wget https://raw.githubusercontent.com/aptly-dev/aptly/master/completion.d/aptly -O /etc/bash_completion.d/aptly \
  && echo "if ! shopt -oq posix; then\n\
  if [ -f /usr/share/bash-completion/bash_completion ]; then\n\
    . /usr/share/bash-completion/bash_completion\n\
  elif [ -f /etc/bash_completion ]; then\n\
    . /etc/bash_completion\n\
  fi\n\
fi" >> /etc/bash.bashrc

COPY files/aptly.conf /etc/aptly.conf
COPY files/*.sh /opt/

# Bind mount location
VOLUME ["/opt/aptly"]

# Execute Startup script when container starts
ENTRYPOINT ["/opt/startup.sh"]

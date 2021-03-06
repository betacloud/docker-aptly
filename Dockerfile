FROM ubuntu:18.04
LABEL maintainer="Betacloud Solutions GmbH (https://www.betacloud-solutions.de)"

ARG VERSION
ENV VRSION ${VERSION:-latest}

ENV DEBIAN_FRONTEND noninteractive

COPY files/aptly.gpg /etc/apt/aptly.gpg

RUN apt-get update \
   && apt-get install --no-install-recommends -y \
       gnupg \
       gpgv \
   && printf "deb http://repo.aptly.info/ squeeze main" > /etc/apt/sources.list.d/aptly.list \
   && apt-key add /etc/apt/aptly.gpg \
   && apt-get update \
   && apt-get install --no-install-recommends -y \
       ca-certificates \
       bash-completion \
       bzip2 \
       curl \
       graphviz \
       lsb-release \
       wget \
       xz-utils \
  && if [ $VERSION != "latest" ]; then apt-get install --no-install-recommends -y aptly=$VERSION; else apt-get install --no-install-recommends -y aptly; fi \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && wget https://raw.githubusercontent.com/aptly-dev/aptly/master/completion.d/aptly -O /etc/bash_completion.d/aptly \
  && printf "if ! shopt -oq posix; then\n\
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

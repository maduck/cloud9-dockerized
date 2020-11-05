#  _
# | |__  __ _ ___ ___
# | '_ \/ _` (_-</ -_)
# |_.__/\__,_/__/\___|
FROM debian:stable-slim
RUN apt-get update && \
    apt-get -y install curl build-essential apt-transport-https lsb-release git zip locales-all python2.7-minimal
#               _      _
#  _ _  ___  __| |___ (_)___
# | ' \/ _ \/ _` / -_)| (_-<
# |_||_\___/\__,_\___|/ /__/
#                   |__/
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get -y install nodejs
#   ___ _             _ ___
#  / __| |___ _  _ __| / _ \
# | (__| / _ \ || / _` \_, /
#  \___|_\___/\_,_\__,_|/_/
RUN git clone https://github.com/c9/core.git /opt/cloud9
WORKDIR /opt/cloud9
RUN scripts/install-sdk.sh
RUN sed -i 's/127.0.0.1/0.0.0.0/' /opt/cloud9/configs/standalone.js
RUN mkdir -p /opt/cloud9/workspace
VOLUME /opt/cloud9/workspace
EXPOSE 8080
#           _
#  __ _ ___| |__ _ _ _  __ _
# / _` / _ \ / _` | ' \/ _` |
# \__, \___/_\__,_|_||_\__, |
# |___/                |___/
RUN curl -sL https://storage.googleapis.com/golang/go1.11.8.linux-amd64.tar.gz | tar xz -C /usr/local/
ENV GOPATH /opt/cloud9/workspace
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

#     _
#  __| |___ __ _ _ _ _  _ _ __
# / _| / -_) _` | ' \ || | '_ \
# \__|_\___\__,_|_||_\_,_| .__/
#                        |_|
RUN apt-get autoclean && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt/cloud9
ENV NODE_ENV production
CMD ["node", "/opt/cloud9/server.js", "--collab", "--port", "8080", "-w", "/opt/cloud9/workspace"]

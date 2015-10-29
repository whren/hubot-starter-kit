FROM dock0/arch

ENV NODEJS_VERSION 0.12.7
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/n/bin

RUN pacman -Syyu --noconfirm && \
    pacman-db-upgrade && \
    pacman -S --noconfirm make gcc && \
    curl -L http://git.io/n-install | bash -s -- -y $NODEJS_VERSION && \
    pacman -S --noconfirm phantomjs && \
    yes | pacman -Scc && \
    echo 'unsafe-perm = true' >> ~/.npmrc && \
    npm install -g coffee-script && \
    mkdir -p /opt/hubot

WORKDIR /opt/hubot

COPY package.json package.json
COPY scripts/ scripts/

#RUN npm install
RUN npm install --production

EXPOSE 8080

#ENTRYPOINT ["npm", "run", "start-dev", "--"]
ENTRYPOINT ["npm", "start", "--"]

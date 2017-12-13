FROM ruby:2.4.2
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install -y qt5-default libqt5webkit5-dev fonts-ipafont-gothic
RUN apt-get install -y gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xvfb

# for a JS runtime
RUN apt-get install -y nodejs npm

# upgrade node
RUN npm cache clean && npm install n -g
RUN n stable && ln -sf /usr/local/bin/node /usr/bin/node
RUN apt-get purge -y nodejs npm

# intall yarn
RUN apt-get install apt-transport-https
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn

# install Docker client

ENV DOCKER_VER "17.03.0-ce"
RUN curl -L -o /tmp/docker-$DOCKER_VER.tgz https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VER.tgz
RUN tar -xz -C /tmp -f /tmp/docker-$DOCKER_VER.tgz
RUN mv /tmp/docker/* /usr/bin

# Install Docker Compose
RUN curl -L https://github.com/docker/compose/releases/download/1.11.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

# install psql command
RUN apt-get install -y postgresql-client

ENV XDG_CACHE_HOME /tmp

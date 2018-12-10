FROM ruby:2.5.3
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

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

# install chrome for headless testing
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update -qq && apt-get install -y google-chrome-stable unzip
RUN cd /tmp && wget -q http://chromedriver.storage.googleapis.com/2.37/chromedriver_linux64.zip && unzip chromedriver_linux64.zip && mv chromedriver /usr/local/bin
RUN apt-get install -y fonts-ipafont-gothic

ENV XDG_CACHE_HOME /tmp

FROM ruby:2.6.5-buster

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get update -qq && apt-get install -y \
    apt-utils \
    build-essential \
    curl \
    libpq-dev \
  && rm -Rf /var/lib/apt/lists/*

# install node.js
# https://github.com/nodesource/distributions/blob/master/README.md#debinstall
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get -qq update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs \
  && rm -Rf /var/lib/apt/lists/*

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" > \
     /etc/apt/sources.list.d/yarn.list \
  && apt update \
  && apt install yarn

ENV RAILS_ROOT /var/www/kleinodien
RUN mkdir -p $RAILS_ROOT/tmp/pids
WORKDIR $RAILS_ROOT

RUN gem install bundler

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

COPY . .

RUN bundle install

# config/database.yml is ignored by .dockerignore.
# Otherwise it can't be copied.
RUN cp config/database_docker.yml config/database.yml

#CMD [ "/bin/bash" ]
CMD [ "config/containers/app_cmd.sh" ]

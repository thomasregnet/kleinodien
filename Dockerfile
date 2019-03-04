FROM ruby:2.6.1
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get update -qq && apt-get install -y \
    apt-utils \
    build-essential \
    curl \
    libpq-dev

# install node.js
# https://github.com/nodesource/distributions/blob/master/README.md#debinstall
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -qq -y nodejs

ENV RAILS_ROOT /var/www/kleinodien
RUN mkdir -p $RAILS_ROOT/tmp/pids
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN gem install bundler

COPY . .

RUN bundle install

# config/database.yml is ignored by .dockerignore.
# Otherwise it can't be copied.
RUN cp config/database_docker.yml config/database.yml

#CMD [ "/bin/bash" ]
CMD [ "config/containers/app_cmd.sh" ]

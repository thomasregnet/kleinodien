FROM ruby:2.6.1-alpine3.9
# FROM ruby:2.6.1
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# RUN apt-get update -qq && apt-get install -y \
#    apt-utils \
#    build-essential \
#    curl \
#    libpq-dev \
#  && rm -Rf /var/lib/apt/lists/*

RUN apk --update add \
    bash \
    build-base \
    nodejs \
    libxslt-dev \
    libxml2-dev \
    postgresql-dev \
    tzdata \
  && rm -Rf /var/cache/apk/*

# install node.js
# https://github.com/nodesource/distributions/blob/master/README.md#debinstall
# RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
#  && apt-get -qq update \
#  && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs \
#  && rm -Rf /var/lib/apt/lists/*

ENV RAILS_ROOT /var/www/kleinodien
RUN mkdir -p $RAILS_ROOT/tmp/pids
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

# RUN gem install bundler

COPY . .

RUN bundle install --jobs=4

# config/database.yml is ignored by .dockerignore.
# Otherwise it can't be copied.
RUN cp config/database_docker.yml config/database.yml

#CMD [ "/bin/bash" ]
CMD [ "config/containers/app_cmd.sh" ]

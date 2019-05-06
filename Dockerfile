FROM ruby:2.6.3-alpine3.9

RUN apk --update add \
    bash \
    build-base \
    nodejs \
    libxslt-dev \
    libxml2-dev \
    postgresql-dev \
    tzdata \
  && rm -Rf /var/cache/apk/*

ENV RAILS_ROOT /var/www/kleinodien
RUN mkdir -p $RAILS_ROOT/tmp/pids
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

COPY . .

RUN bundle install --jobs=4

# config/database.yml is ignored by .dockerignore.
# Otherwise it can't be copied.
RUN cp config/database_docker.yml config/database.yml

CMD [ "config/containers/app_cmd.sh" ]

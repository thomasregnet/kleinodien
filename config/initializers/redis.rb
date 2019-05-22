# https://stackoverflow.com/questions/24962319/is-there-a-more-direct-way-to-do-a-pub-sub-pattern-in-rails-than-observers

redis = Redis.new(url: ENV.fetch('REDIS_URL', 'redis://redis:6379'))

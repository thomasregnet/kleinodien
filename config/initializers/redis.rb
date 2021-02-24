# https://stackoverflow.com/questions/24962319/is-there-a-more-direct-way-to-do-a-pub-sub-pattern-in-rails-than-observers

# config/initializers/redis.rb
uri = URI.parse ENV.fetch("REDISTOGO_URL", 'http://127.0.0.1:6379')
REDIS_CONFIG = { host: uri.host, port: uri.port, password: uri.password }
REDIS = Redis.new(url: ENV.fetch('REDIS_URL', 'redis://redis:6379'))

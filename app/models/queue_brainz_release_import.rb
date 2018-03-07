class QueueBrainzReleaseImport
  include ActiveModel::Model

  attr_accessor :code
  validates :code, presence: true

  def self.perform(params)
    new(params).perform
  end

  def perform
    redis = ImportConnection.redis # Redis.new(host: 'redis', timeout: 3)
    redis.rpush('brainz:wait', code)
  end
end

class QueueBrainzReleaseImport
  include ActiveModel::Model

  attr_accessor :code
  validates :code, presence: true
end

# frozen_string_literal: true

# Queue users orders of metadata imports
class ImportOrder < ApplicationRecord
  include ImportStateTransitions

  belongs_to :import_queue
  belongs_to :user
  has_many :artist_credits
  has_many :artists
  has_many :release_heads
  has_many :release_tracks
  has_many :releases
  has_many :import_requests
  has_many :medium_formats
  has_many :piece_heads
  has_many :pieces

  after_initialize :set_default_state

  validates :code, :import_queue, :state, :user, presence: true

  validates :state, inclusion: { in: %w[pending processing done failed] }

  validates_uniqueness_of(
    :code,
    scope:      %i[import_queue_id type],
    conditions: -> { where(state: %w[pending processing]) }
  )

  before_validation :ensure_code_and_type_hava_a_value
  before_validation :ensure_import_queue_has_a_value

  after_save :publish

  def publish
    return unless pending?

    REDIS.publish(publication_channel_name, 'run')
  end

  def self.publication_channel_name
    "publish_#{to_s.underscore.pluralize}"
  end

  def publication_channel_name
    return self.class.publication_channel_name unless type

    "publish_#{type.to_s.underscore.pluralize}"
  end

  # OPTIMIZE: The methods .import_queue_name and #import_queue_name are not DRY
  def self.import_queue_name
    "#{to_s.underscore.pluralize}_queue"
  end

  def self.next_pending
    orders = where(state: 'pending').order('created_at asc').limit(1)
    return if orders.empty?

    orders.first
  end

  def import_queue_name
    klass = self.class.to_s
    "#{klass.underscore.pluralize}_queue"
  end

  private

  def set_default_state
    return if state

    self.state = 'pending'
  end

  # def ensure_code_and_import_queue_and_type_hava_a_value
  def ensure_code_and_type_hava_a_value
    return if code || type
    return unless uri

    import_values = AnalyzeImportOrderUriService.call(uri_string: uri) || return
    self.code         = import_values[:code]
    self.type         = import_values[:type]
  end

  def ensure_import_queue_has_a_value
    return if import_queue

    self.import_queue = ImportQueue.find_by(name: import_queue_name)
  end
end

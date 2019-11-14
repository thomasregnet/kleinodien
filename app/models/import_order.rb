# frozen_string_literal: true

# Queue users orders of metadata imports
class ImportOrder < ApplicationRecord
  include AASM

  ACTIVE_STATES = %w[pending preparing persisting].freeze

  belongs_to :import_queue
  belongs_to :user
  has_many :areas
  has_many :artist_credits
  has_many :artists
  has_many :import_requests
  has_many :medium_formats
  has_many :piece_heads
  has_many :pieces
  has_many :release_heads
  has_many :release_tracks
  has_many :releases

  validates :code, presence: true
  validates(
    :state,
    presence:  true,
    inclusion: { in: %w[pending preparing persisting done failed] }
  )

  validates_uniqueness_of(
    :code,
    scope: :type,
    if:    proc { |order| order.active? }
  )

  before_validation :ensure_code_and_type_hava_a_value
  before_validation :ensure_import_queue_has_a_value

  after_initialize :set_default_state
  after_save :publish

  aasm column: :state, whiny_persistence: true do
    state :pending, initial: true
    state :preparing, :persisting, :done, :failed

    after_all_transitions { save! }

    event :prepare do
      transitions from: :pending, to: :preparing
    end

    event :persist do
      transitions from: :preparing, to: :persisting
    end
    event :done do
      transitions from: :persisting, to: :done
    end

    event :failure do
      transitions from: %i[pending preparing persisting], to: :failed
    end
  end

  def active?
    ACTIVE_STATES.include?(state)
  end

  def publish
    return unless pending?
    return unless import_queue

    REDIS.publish(import_queue.name, 'run')
  end

  def self.next_pending
    orders = where(state: 'pending').order('created_at asc').limit(1)
    return if orders.empty?

    orders.first
  end

  private

  def default_import_queue_name; end

  def ensure_code_and_type_hava_a_value
    return if code || type
    return unless uri

    import_values = AnalyzeImportOrderUriService.call(uri_string: uri) || return
    self.code     = import_values[:code]
    self.type     = import_values[:type]
  end

  def ensure_import_queue_has_a_value
    return if import_queue

    ensure_code_and_type_hava_a_value unless type
    return unless type

    # OPTIMIZE: The ImportQueue is seeded. DatabaseCleaner removes it.
    # It would be nicer if the ImportQueue is found via "find_by" instead
    # of "find_or_create_by".
    # self.import_queue = ImportQueue.find_or_create_by(name: 'brainz')
    self.import_queue = ImportQueue.find_or_create_by!(
      # name: default_import_queue_name
      name: type.constantize.default_import_queue_name
    )
  end

  def set_default_state
    return if state

    self.state = 'pending'
  end
end

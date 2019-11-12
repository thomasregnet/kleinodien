# frozen_string_literal: true

# Base class for ImportRequests
class ImportRequest < ApplicationRecord
  include AASM

  belongs_to :import_order, counter_cache: :requests_count
  has_one :body, class_name: 'ImportRequestBody'
  has_many :attempts,
           class_name: 'ImportRequestAttempt',
           inverse_of: :import_request

  validates :code, :state, :type, presence: true
  validates :state, inclusion: { in: %w[pending running done failed] }

  aasm column: :state do
    state :pending, initial: true
    state :running, :done, :failed

    after_all_transitions { save! }

    event :run do
      transitions from: :pending, to: :running
    end

    event :done do
      transitions from: :running, to: :done
    end

    event :failure do
      transitions from: %i[pending running], to: :failed
    end
  end
end

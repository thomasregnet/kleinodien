# frozen_string_literal: true

# Base class for ImportRequests
class ImportRequest < ApplicationRecord
  belongs_to :import_order, counter_cache: :requests_count
  has_one :body, class_name: 'ImportRequestBody'
  has_many :attempts, class_name: 'ImportRequestAttempt'

  validates :code, :state, :type, presence: true
  validates :state, inclusion: { in: %w[pending processing done failed] }

  def processing
    return unless state == 'pending'

    self.state = 'processing'
  end

  def done
    return unless state == 'processing' || state == 'pending'

    self.state = 'done'
  end

  def failed
    return unless state == 'pending' || state == 'processing'

    self.state = 'failed'
  end
end

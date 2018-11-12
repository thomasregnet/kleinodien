# frozen_string_literal: true

# Base class for ImportRequests
class ImportRequest < ApplicationRecord
  belongs_to :import_order

  validates :attempts_cache, :code, :state, :type, presence: true
  validates :state, inclusion: { in: %w[pending processing done failed] }
end

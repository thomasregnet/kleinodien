class ImportRequestAttempt < ApplicationRecord
  belongs_to :import_request, counter_cache: :attempts_count
  validates :status_code,
            numericality: {
              greater_than_or_equal_to: 100,
              less_than_or_equal_to: 999
            }
end

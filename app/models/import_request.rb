# frozen_string_literal: true

# Base class for ImportRequests
class ImportRequest < ApplicationRecord
  belongs_to :import_order
end

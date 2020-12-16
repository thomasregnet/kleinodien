# frozen_string_literal: true

# Content of the body of an ImportRequest
class ImportRequestBody < ApplicationRecord
  belongs_to :import_request

  validates :content, presence: true
end

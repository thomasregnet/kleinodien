class ImportRequestBody < ApplicationRecord
  belongs_to :import_request

  validates :content, presence: true, blank: false
end

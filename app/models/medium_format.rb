class MediumFormat < ApplicationRecord
  belongs_to :import_order, required: false

  validates :name, presence: true
end

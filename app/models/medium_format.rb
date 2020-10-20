# frozen_string_literal: true

# The kind of a medium
class MediumFormat < ApplicationRecord
  belongs_to :import_order, required: false

  has_many :media, class_name: 'ReleaseMedium'

  validates :brainz_code, uniqueness: true, allow_nil: true
  validates :name, presence: true, uniqueness: { case_insensitive: false }
end

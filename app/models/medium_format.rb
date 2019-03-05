# frozen_string_literal: true

# The kind of a medium
class MediumFormat < ApplicationRecord
  belongs_to :import_order, required: false

  has_many :heap_media

  validates :name, presence: true
end

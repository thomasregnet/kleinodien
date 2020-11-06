# frozen_string_literal: true

# Heading of sets
class ReleaseHead < ApplicationRecord
  belongs_to :artist_credit, required: false
  belongs_to :import_order, required: false

  validates :title, presence: true, blank: false

  has_one_attached :front_cover
end

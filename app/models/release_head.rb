# frozen_string_literal: true

# Heading of sets
class ReleaseHead < ApplicationRecord
  belongs_to :artist_credit, required: false
  belongs_to :import_order, required: false

  has_many :releases, class_name: 'Release', foreign_key: :release_head_id

  validates :title, presence: true

  has_one_attached :front_cover
end

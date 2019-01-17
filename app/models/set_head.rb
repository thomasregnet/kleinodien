# frozen_string_literal: true

# Heading of sets
class SetHead < ApplicationRecord
  belongs_to :artist_credit, required: false
  belongs_to :import_order, required: false
  belongs_to :season, required: false

  validates :title, presence: true, blank: false
end

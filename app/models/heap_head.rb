# frozen_string_literal: true

# Heading of sets
class HeapHead < ApplicationRecord
  belongs_to :artist_credit, required: false
  belongs_to :import_order, required: false

  validates :title, presence: true, blank: false
end

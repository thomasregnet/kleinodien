# frozen_string_literal: true

# Tags for images
class ImageTag < ApplicationRecord
  has_and_belongs_to_many :release_images
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

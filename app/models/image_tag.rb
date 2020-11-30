# frozen_string_literal: true

# Tags for images
class ImageTag < ApplicationRecord
  has_and_belongs_to_many :release_images
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.find_or_create_by_name(name)
    where('LOWER(name) = ?', name.downcase).first || create(name: name)
  end
end

# frozen_string_literal: true

class ImageTag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

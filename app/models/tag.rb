class Tag < ApplicationRecord
  validates :name,
            presence: true,
            blank: false,
            uniqueness: { case_sensitive: false }
end

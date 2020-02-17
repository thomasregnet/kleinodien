# frozen_string_literal: true

# Company, for example a label
class Company < ActiveRecord::Base
  belongs_to :area, required: false

  has_many :release_companies

  validates :name,
            presence:   true,
            blank:      false,
            uniqueness: { case_sensitive: false }
end

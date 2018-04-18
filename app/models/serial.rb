# frozen_string_literal: true

# Base class for serials like TV-serials or podcast-serials
class Serial < ActiveRecord::Base
  include CodeFindable

  has_and_belongs_to_many :tags
  has_many :comments
  has_many :descriptions
  has_many :seasons, inverse_of: :serial
  has_many :ratings

  validates :title,
            presence: true,
            uniqueness: { scope: :disambiguation, case_sensitive: false }
end

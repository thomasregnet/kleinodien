# frozen_string_literal: true

# Season of a serial, has many episodes
class Season < ActiveRecord::Base
  include CodeFindable

  belongs_to :serial, inverse_of: :seasons
  has_and_belongs_to_many :tags
  has_many :episodes, class_name: 'EpisodeHead', inverse_of: :season
  has_many :ratings

  validates :position, presence: { message: "position can't be blank" }
end

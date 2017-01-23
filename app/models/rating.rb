class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :artist_redit
end

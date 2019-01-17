class SetHead < ApplicationRecord
  belongs_to :artist_credit
  belongs_to :import_order
  belongs_to :season
end

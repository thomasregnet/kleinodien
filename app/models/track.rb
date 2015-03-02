class Track < ActiveRecord::Base
  belongs_to :format
  belongs_to :piece_release
end

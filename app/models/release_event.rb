class ReleaseEvent < ApplicationRecord
  belongs_to :release
  belongs_to :area
end

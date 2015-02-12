class Serial < ActiveRecord::Base
  validates :title, presence: true
end

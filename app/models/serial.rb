class Serial < ActiveRecord::Base
  validates :title, presence: true
  validates_uniqueness_of :title, scope: :disambiguation, case_sensitive: false
end

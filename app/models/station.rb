class Station < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name,
                          scope: :disambiguation,
                          case_sensitive: false
end

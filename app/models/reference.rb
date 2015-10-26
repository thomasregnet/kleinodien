class Reference < ActiveRecord::Base
  belongs_to :data_supplier
  validates :data_supplier, presence: true
  validates :identifier, presence: true, blank: false
  validates :type, presence: true, blank: false
end

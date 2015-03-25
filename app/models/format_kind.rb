class FormatKind < ActiveRecord::Base
  validates :name, presence: true, blank: false
  validates :type, presence: true, blank: false
end

class SourceIdentifier < ActiveRecord::Base
  belongs_to :data_source
  validates :data_source, presence: true
  validates :identifier, presence: true, blank: false
  validates :type, presence: true, blank: false
end

# One of possibly many formats of a ComplationRelease
class CrFormat < ActiveRecord::Base
  belongs_to :format
  belongs_to :release,
             class_name: 'CompilationRelease',
             foreign_key: :compilation_release_id

  has_many :details,
           class_name: 'CrFormatDetail'

  validates :format,   presence: true
  validates :position, presence: true, uniqueness: { scope: :release }
  validates :quantity, presence: true
  validates :release,  presence: true

  alias_attribute :format_details, :details

  delegate :name, to: :format
end

class CompilationHead < ActiveRecord::Base
  validates :title, presence: true
  validates :type, presence: true
  validates_uniqueness_of(
    :title,
    scope: [:type, :disambiguation],
    case_sensitive: false
  )
  has_many :credits, class_name: ChCredit
end

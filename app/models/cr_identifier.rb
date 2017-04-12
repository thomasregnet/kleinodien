# Foreign identifiers of CompilationRelease
class CrIdentifier < ApplicationRecord
  belongs_to :compilation_release
  belongs_to :source
  validates :compilation_release, presence: true
  validates :source, presence: true
  validates :value, presence: true, blank: false

  alias_attribute :identified, :compilation_release
end

# Foreign identifiers of CompilationRelease
class CompilationReleaseIdentifier < ApplicationRecord
  belongs_to :compilation_release
  belongs_to :source

  validates :value, presence: true, blank: false

  alias_attribute :identified, :compilation_release
end

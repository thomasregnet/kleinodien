# Foreign identifiers of CompilationHead
class CompilationHeadIdentifier < ApplicationRecord
  belongs_to :compilation_head
  belongs_to :source

  validates :value, presence: true, blank: false

  alias_attribute :identified, :compilation_head
end

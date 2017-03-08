class ChIdentifier < ApplicationRecord
  belongs_to :compilation_head
  belongs_to :source

  validates :compilation_head, presence: true
  validates :source, presence: true
  validates :value, presence: true, blank: false

  alias_attribute :identified, :compilation_head
end

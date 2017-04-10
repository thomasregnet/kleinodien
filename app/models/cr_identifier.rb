class CrIdentifier < ApplicationRecord
  belongs_to :compilation_release
  belongs_to :source
  validates :compilation_release, presence: true
  validates :source, presence: true
  validates :value, presence: true, blank: false

  alias_attribute :identified, :compilation_release
  # alias_attribute :alt_identified, :compilation_releases
end

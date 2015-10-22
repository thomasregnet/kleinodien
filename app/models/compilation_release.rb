class CompilationRelease < ActiveRecord::Base
  composed_of :date,
              class_name: 'IncompleteDate',
              mapping: [ %w(date date), %w(date_mask mask) ]
  validates :head, presence: true
  validates :type, presence: true
  belongs_to(
    :head,
    class_name: CompilationHead,
    foreign_key: :compilation_head_id)
  belongs_to :source_identifier, class_name: CrSourceIdentifier
  has_many :companies, class_name: CrCompany
  has_many :credits, class_name: CrCredit
  #has_many :compilation_releases_countries, inverse_of: :compilation_release
  has_and_belongs_to_many :countries
  #has_many :countries, through: :compilation_releases_countries

  #has_many :compilation_releases_countries, inverse_of: :countries
  has_many(
    :identifiers,
    class_name: CompilationIdentifier)
  has_many :labels, class_name: CrLabel
  has_many(:tracks)
  has_many(
    :formats,
    class_name: CrFormat,
    foreign_key: :compilation_release_id)
  validates_uniqueness_of :source_identifier, allow_nil: true
  validates_uniqueness_of :version, scope: :head, case_sensitive: false
  delegate :title, to: :head
end

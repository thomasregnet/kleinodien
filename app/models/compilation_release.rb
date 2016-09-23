# A CompilationRelease may be an Album, a movie box ...
class CompilationRelease < ActiveRecord::Base
  composed_of :date,
              class_name: 'IncompleteDate',
              mapping: [%w(date date), %w(date_mask mask)]

  belongs_to :head,
             class_name: CompilationHead,
             foreign_key: :compilation_head_id
  belongs_to :source, foreign_key: :source_name
  has_many :companies, class_name: CrCompany
  has_many :credits, class_name: CrCredit
  has_many :formats,
           class_name: CrFormat,
           foreign_key: :compilation_release_id
  has_many :identifiers,
           class_name: CompilationIdentifier
  has_many :labels, class_name: CrLabel
  has_many :tracks
  has_and_belongs_to_many :countries

  validates :head, presence: true
  validates :type, presence: true
  validates :version, uniqueness: { scope: :head, case_sensitive: false }

  delegate :title, to: :head
end

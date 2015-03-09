class CompilationSection < ActiveRecord::Base
  belongs_to(
    :format,
    class_name: SectionFormat,
    foreign_key: :section_format_id)
  belongs_to(
    :medium, class_name: CompilationMedium,
    foreign_key: :compilation_medium_id)
  has_many(
    :tracks,
    inverse_of: :section)
  validates :medium, presence: true
  validates :format, presence: true
  validates :side, inclusion: { in: %w(A B) }, allow_nil: true
  validates_uniqueness_of(
    :medium,
    conditions: -> { where('side IS NULL') } )
  validates_uniqueness_of(
    :medium,
    scope: [:side],
    conditions: -> { where('side IS NOT NULL') } )
end

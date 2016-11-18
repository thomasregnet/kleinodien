class CompilationCopy < ApplicationRecord
  #belongs_to :compilation_release
  belongs_to :release,
             class_name:  CompilationRelease,
             foreign_key: :compilation_release_id
  belongs_to :user, inverse_of: :compilation_copies

  validates :release, presence: true
  validates :user, presence: true

  has_many :repositories, through: :user

  accepts_nested_attributes_for :repositories
  # def release(release)
  #   self.

  # def repository_ids
  # end

  # def repository_ids=
  # end
end

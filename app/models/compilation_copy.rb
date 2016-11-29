# CompilationCopy holds user copies
class CompilationCopy < ApplicationRecord
  belongs_to :release,
             class_name:  CompilationRelease,
             foreign_key: :compilation_release_id
  belongs_to :user, inverse_of: :compilation_copies

  validates :release, presence: true
  validates :user, presence: true

  has_many :repositories, through: :user

  accepts_nested_attributes_for :repositories
end

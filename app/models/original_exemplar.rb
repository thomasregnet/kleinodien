# An original in an users collection
class OriginalExemplar < ApplicationRecord
  belongs_to :compilation_release
  belongs_to :user

  validates :disambiguation, presence: true
end

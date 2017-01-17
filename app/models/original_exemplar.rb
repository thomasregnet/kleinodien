class OriginalExemplar < ApplicationRecord
  belongs_to :compilation_release
  belongs_to :user

  validates :compilation_release, presence: true
  validates :disambiguation,      presence: true
  validates :user,                presence: true
end

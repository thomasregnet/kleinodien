class RepositoryPosition < ApplicationRecord
  belongs_to :compilation_track,
             primary_key: [:id, :compilation_release_id],
             foreign_key: [:compilation_track_id, :compilation_release_id]

  belongs_to :repository
  belongs_to :user

  validates :repository, presence: true
  validates :user, presence: true

  def compilation_track=(ct)
    self.compilation_track_id   = ct.id
    self.compilation_release_id = ct.compilation_release_id
  end
end

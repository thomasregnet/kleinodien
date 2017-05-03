# A position of a content in an users repository
class RepositoryPosition < ApplicationRecord
  belongs_to :compilation_copy, required: false
  belongs_to :compilation_track, required: false
  belongs_to :piece_track, required: false
  belongs_to :repository
  belongs_to :user

  belongs_to :release,
             class_name: 'CompilationRelease',
             primary_key: :id,
             foreign_key: :compilation_release_id,
             required: false

  validate :only_on_track_type

  validates :compilation_copy,
            presence: true,
            unless: Proc.new { |rp| rp.compilation_track.nil? }
  validates :repository, presence: true
  validates :user, presence: true

  def compilation_copy=(cc)
    if cc
      self.compilation_copy_id    = cc.id
      self.compilation_release_id = cc.compilation_release_id
      self.user_id                = cc.user_id
    else
      clear_compilation_copy
    end
  end

  # TODO: compilation_track can be nil
  def compilation_track=(ct)
    self.compilation_track_id   = ct.id
    self.compilation_release_id = ct.compilation_release_id
  end

  private

  def clear_compilation_copy
    self.compilation_copy_id    = nil
    self.compilation_release_id = nil
    self.user_id                = nil
  end

  def only_on_track_type
    return unless compilation_track
    return unless piece_track
    errors.add(
      :compilation_track,
      "compilation_track can't be used with a piece_track"
    )
    errors.add(
      :piece_track,
      "piece_track can't be used with a compilation_track"
    )
  end
end

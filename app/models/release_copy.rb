# frozen_string_literal: true

class ReleaseCopy < ApplicationRecord
  belongs_to :release_head, required: false
  belongs_to :release, required: false
  belongs_to :user

  validates :designation, presence: true, blank: false, uniqueness: { scope: :user_id }

  validate :release_xor_release_head

  def artist_credit
    return release.artist_credit if release
    return release_head.artist_credit if release_head
  end

  def title
    return release.title if release
    return release_head.title if release_head
  end

  def with_release?
    release ? true : false
  end

  def with_release_head?
    release_head ? true : false
  end

  private

  def release_xor_release_head
    return if with_release? ^ with_release_head?

    if with_release?
      errors.add(:base, 'there can be either a Release or a ReleaseHead')
    else
      errors.add(:base, 'there must be either a Release or a ReleaseHead')
    end
  end
end

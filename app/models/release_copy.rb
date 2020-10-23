# frozen_string_literal: true

class ReleaseCopy < ApplicationRecord
  belongs_to :release_head, required: false
  belongs_to :release, required: false
  belongs_to :user

  validate :release_xor_release_head

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
      errors.add(:base, 'there can be eigther a Release or a ReleaseHead')
    else
      errors.add(:base, 'there must be eigther a Release or a ReleaseHead')
    end
  end
end

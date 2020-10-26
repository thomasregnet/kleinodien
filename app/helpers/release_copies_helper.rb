# frozen_string_literal: true

module ReleaseCopiesHelper
  def release_copy_title_for(release, release_head)
    return release.title if release
    return release_head.title if release_head
  end

  def release_copy_artist_credit_for(release, release_head)
    name = release&.artist_credit&.name || release_head&.artist_credit&.name
    return unless name

    "by #{name}"
  end
end

# frozen_string_literal: true

module ReleaseCopiesHelper
  def release_copy_title_for(params)
    release_copy_of_for(params)&.title
  end

  def release_copy_artist_credit_for(params)
    release_copy_of_for(params)&.artist_credit&.name
  end

  private

  def release_copy_of_for(params)
    release_id = params[:release_id]
    return Release.find(release_id) if release_id

    release_head_id = params[:release_head_id]
    return ReleaseHead.find(release_head_id) if release_head_id
  end
end

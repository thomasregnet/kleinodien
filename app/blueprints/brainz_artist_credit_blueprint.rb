# frozen_string_literal: true

# Artist-credit representation for MusicBrainz-data
class BrainzArtistCreditBlueprint < Hashie::Mash
  def join_name
    credits = name_credits
    return unless credits

    JoinBrainzArtistCreditService.call(name_credits: credits)
  end

  def brainz_code
    id
  end
end

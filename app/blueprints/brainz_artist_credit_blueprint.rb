# frozen_string_literal: true

# Artist-credit representation for MusicBrainz-data
class BrainzArtistCreditBlueprint < Hashie::Mash
  include BrainzCodeBlueprint

  def join_name
    credits = name_credits
    return unless credits

    JoinBrainzArtistCreditService.call(name_credits: credits)
  end
end

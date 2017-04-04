module MashedBrainz
  class ArtistCredit < Base
    def name
      KleinodienUtil::JoinNames.perform(
        name_credit,
        join_phrase: 'stripped_joinphrase')
    end

    def name_credits
      name_credit
    end
  end
end
    

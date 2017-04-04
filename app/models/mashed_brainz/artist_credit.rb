module MashedBrainz
  class ArtistCredit < Base
    def name
      KleinodienUtil::JoinNames.perform(
        name_credit,
        join_phrase: 'stripped_joinphrase')
    end
  end
end
    

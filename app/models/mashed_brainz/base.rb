module MashedBrainz
  class Base < Hashie::Mash
    disable_warnings

    include Hashie::Extensions::Coercion

    coerce_key :artist_credit, MashedBrainz::ArtistCredit
  end
end

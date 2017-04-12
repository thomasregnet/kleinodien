module MashedBrainz
  # Base class for representations of MusicBrainz entities
  class Base < Hashie::Mash
    disable_warnings

    include Hashie::Extensions::Coercion
    include Hashie::Extensions::MergeInitializer

    coerce_key :artist, lambda { |value|
      MashedBrainz::Artist.new(value)
    }

    coerce_key :artist_credit, lambda { |value|
      MashedBrainz::ArtistCredit.new(value)
    }

    coerce_key :name_credit, lambda { |value|
      if value.is_a? Array
        value.map do |nc|
          MashedBrainz::NameCredit.new(nc)
        end
      else
        [MashedBrainz::NameCredit.new(value)]
      end
    }
  end
end

module MashedBrainz
  class Base < Hashie::Mash
    disable_warnings

    include Hashie::Extensions::Coercion
    include Hashie::Extensions::MergeInitializer

    #coerce_key :artist_credit, MashedBrainz::ArtistCredit
    coerce_key :artist, ->(value) do
      MashedBrainz::Artist.new(value)
    end

    coerce_key :artist_credit, ->(value) do
      #byebug
      MashedBrainz::ArtistCredit.new(value)
    end

    #coerce_key :name_credit, MashedBrainz::NameCredit
    coerce_key :name_credit, ->(value) do
      if value.kind_of? Array
        value.map do |nc|
          MashedBrainz::NameCredit.new(nc)
        end
      else
        [MashedBrainz::NameCredit.new(value)]
      end
    end
  end
end

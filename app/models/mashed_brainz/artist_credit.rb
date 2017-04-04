module MashedBrainz
  class ArtistCredit < Base
    #include Hashie::Extensions::Coercion
    #include Hashie::Extensions::MergeInitializer
    #coerce_key :name_credit, MashedBrainz::NameCredit
  end
end
    

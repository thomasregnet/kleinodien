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

    coerce_key :relation, lambda { |value|
      if value.is_a? Array
        value.map do |nc|
          MashedBrainz::Relation.new(nc)
        end
      else
        [MashedBrainz::Relation.new(value)]
      end
    }

    def relations_for_target(type)
      return unless relation_lists
      relation_lists.each do |r_list|
        next unless r_list.target_type == type.to_s
        return r_list.relation
      end
    end

    def relation_lists
      force_array(relation_list)
    end

    def force_array(gizmo)
      return unless gizmo
      return gizmo if gizmo.is_a? Array
      Hashie::Array.new([gizmo])
    end
  end
end

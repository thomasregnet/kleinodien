module MashedBrainz
  # MusicBrainz release-group
  class ReleaseGroup < Base
    def reference
      BrainzReleaseGroupRef.new(code: id)
    end

    def relation_list_for(type_symbol)
      type = type_symbol.to_s
      relation_lists.each do |relation_list|
        return relation_list if relation_list.target_type == type
      end

      nil
    end
  end
end

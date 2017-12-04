module MashedBrainz
  # MusicBrainz url-rels
  class UrlRels < Base
    def discogs
      relation.each do |rel|
        return rel if rel.type == 'discogs'
      end
    end

    def discogs_code
      url = discogs_url
      return unless url
      /(\d+)$/.match(url)[1]
    end

    def discogs_url
      rel = discogs || return
      rel.target.__content__
    end

    def wikidata
      relation.each do |rel|
        return rel if rel.type == 'wikidata'
      end
    end

    def wikidata_code
      url = wikidata_url || return
      %r{\/(Q\d+)$}.match(url)[1]
    end

    def wikidata_url
      rel = wikidata || return
      rel.target.__content__
    end
  end
end

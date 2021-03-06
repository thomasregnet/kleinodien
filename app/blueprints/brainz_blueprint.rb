# frozen_string_literal: true

# Blueprint for MusicBrainz-imports
class BrainzBlueprint < Hashie::Mash
  include BrainzCodeBlueprint
  include Hashie::Extensions::Coercion
  include Hashie::Extensions::MergeInitializer

  CODE_NAMES = %w[brainz_code discogs_code wikidata_code].freeze

  def self.from_xml(xml_string)
    data = MultiXml.parse(xml_string)['metadata']
    prepared_data = PrepareBrainzDataService.call(
      brainz_data: data[data.keys.first]
    )
    new(prepared_data)
  end

  coerce_key :artist_credit, BrainzArtistCreditBlueprint

  def incomplete_begin_date
    begin_date && IncompleteDate.from_string(begin_date)
  end

  def incomplete_end_date
    end_date && IncompleteDate.from_string(end_date)
  end

  def flat_track_list
    return unless tracks

    FlattenBrainzTrackListService.call(blueprint: self)
  end

  # codes

  def discogs_uri
    return unless url_relations

    relation = url_relations.find { |rel| rel.type == 'discogs' }
    return unless relation

    URI(relation.target.__content__)
  end

  def discogs_code
    uri = discogs_uri || return

    uri.path.split('/')[-1]
  end

  def codes_hash
    codes = {}
    CODE_NAMES.each { |code_name| codes[code_name] = send code_name }
    codes
  end
end

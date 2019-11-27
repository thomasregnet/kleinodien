# frozen_string_literal: true

# Blueprint for MusicBrainz-imports
class BrainzBlueprint < Hashie::Mash
  # disable_warnings
  CODE_NAMES = %w[brainz_code discogs_code wikidata_code].freeze

  def self.from_xml(xml_string)
    intermidiate = new(MultiXml.parse(xml_string)).metadata
    intermidiate[intermidiate.keys.first]
  end

  # artist-credit related

  def join_name
    credits = name_credits
    return unless credits

    JoinBrainzArtistCreditService.call(name_credits: credits)
  end

  def aliases
    return unless alias_list

    force_array(alias_list.alias)
  end

  def incomplete_begin_date
    begin_date && IncompleteDate.from_string(begin_date)
  end

  def incomplete_end_date
    end_date && IncompleteDate.from_string(end_date)
  end

  def iso_3166_1_codes
    return unless iso_3166_1_code_list

    force_array(iso_3166_1_code_list.iso_3166_1_code)
  end

  def iso_3166_2_codes
    return unless iso_3166_2_code_list

    force_array(iso_3166_2_code_list.iso_3166_2_code)
  end

  def iso_3166_3_codes
    return unless iso_3166_3_code_list

    force_array(iso_3166_3_code_list.iso_3166_3_code)
  end

  def media
    return unless medium_list

    force_array(medium_list.medium)
  end

  def milliseconds
    millseconds = self['length'] || return
    millseconds.to_i
  end

  def name_credits
    return unless name_credit

    force_array(name_credit)
  end

  # relations

  def relation_lists
    return unless relation_list

    force_array(relation_list)
  end

  def release_events
    return unless release_event_list

    force_array(release_event_list.release_event)
  end

  def flat_track_list
    return unless self.track_list

    FlattenBrainzTrackListService.call(blueprint: self)
  end

  def url_relations
    return unless relation_lists

    url_rels = relation_lists.find { |rel| rel.target_type == 'url' }
    return unless url_rels

    url_rels.relation
  end

  # codes

  def brainz_code
    id
  end

  def discogs_uri
    return unless url_relations

    relation = url_relations.find { |rel| rel.type == 'discogs' }
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

  # make sure we return a Hashie::Array even when there is only
  # one value
  # This method smells of :reek:UtilityFunction
  def force_array(gizmo)
    return unless gizmo
    return gizmo if gizmo.is_a? Array

    Hashie::Array.new([gizmo])
  end
end

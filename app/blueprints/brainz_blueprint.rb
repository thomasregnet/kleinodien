# frozen_string_literal: true

# Blueprint for MusicBrainz-imports
class BrainzBlueprint < Hashie::Mash
  # disable_warnings

  include Hashie::Extensions::MergeInitializer

  def self.from_xml(xml_string)
    intermidiate = new(MultiXml.parse(xml_string)).metadata
    intermidiate[intermidiate.keys.first]
  end

  def relation_lists
    return unless relation_list

    force_array(relation_list)
  end

  def url_relations
    return unless relation_lists

    url_rels = relation_lists.find { |rel| rel.target_type == 'url' }
    return unless url_rels

    url_rels.relation
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

  # This method smells of :reek:UtilityFunction
  def force_array(gizmo)
    return unless gizmo
    return gizmo if gizmo.is_a? Array

    Hashie::Array.new([gizmo])
  end
end

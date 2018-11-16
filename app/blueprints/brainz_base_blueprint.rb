# frozen_string_literal: true

# Base class for representations of MusicBrainz entities
class BrainzBaseBlueprint < Hashie::Mash
  disable_warnings

  include Hashie::Extensions::Coercion
  include Hashie::Extensions::MergeInitializer

  def self.from_xml(xml_string)
    intermediate = BrainzBaseBlueprint.new(MultiXml.parse(xml_string)).metadata
    key_name = intermediate.keys.first
    intermediate[key_name]
  end

  # To avoid circular coercion we use coercion procs instead of
  # coerce_key :key, ClassName
  coerce_key :artist, lambda { |value|
    BrainzArtistBlueprint.new(value)
  }

  coerce_key :artist_credit, lambda { |value|
    BrainzArtistCreditBlueprint.new(value)
  }

  coerce_key :release, lambda { |value|
    BrainzReleaseBlueprint.new(value)
  }

  coerce_key :release_group, lambda { |value|
    BrainzReleaseGroupBlueprint.new(value)
  }

  coerce_key :name_credit, lambda { |value|
    ForceArrayOfObjectsService.call(
      klass: BrainzNameCreditBlueprint,
      value: value
    )
  }

  coerce_key :relation, lambda { |value|
    ForceArrayOfObjectsService.call(
      klass: BrainzRelationBlueprint,
      value: value
    )
  }

  # coerce_key :relation_list, lambda { |value|
  #   # byebug
  #    if value['target_type'] == 'url'
  #      # byebug
  #      ForceArrayOfObjectsService.call(
  #       klass: BrainzUrlRelsBlueprint, value: value, ossi: 'toll'
  #      )
  #    else
  #   #   ForceArrayOfObjectsService.call(
  #   #     klass: BrainzRelationBlueprint, value: value
  #   #   )
  #    end
  # }
  # coerce_key :relation_list, lambda { |value|
  #   return BrainzUrlRelsBlueprint.new(value) if value['target_type'] == 'url'
  #   BrainzRelationListBlueprint.new(value)
  # }

  def url_relations
    url_rels = relation_lists.find { |rel| rel.target_type == 'url' }
    return unless url_rels

    url_rels.relation
  end

  def relation_lists
    return unless relation_list
    relation_list
  end

  def more_than_one_relation_list?(relation_list)
    return false if relation_list['target_type']
    true
  end

  def relations_for_target(type)
    return unless relation_lists
    relation_lists.each do |r_list|
      next unless r_list.target_type == type.to_s
      return r_list.relation
    end
  end

  # def relation_lists
  #   return unless relation_list
  #   byebug
  # end
  # def relation_lists
  #   force_array(relation_list)
  # end

  def force_array(gizmo)
    return unless gizmo
    return gizmo if gizmo.is_a? Array
    Hashie::Array.new([gizmo])
  end


end

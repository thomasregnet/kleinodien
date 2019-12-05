# frozen_string_literal: true

class PrepareBrainzRelationListService < ServiceBase
  def initialize(relation_list:)
    @relation_list = relation_list
    @result        = {}
  end

  attr_reader :relation_list, :result

  def call
    # relation_list.each { |item| result.merge(prelist(sub_list)) }
    # relations = relation_list['relation'].map do |relation|
    forced_relations = force_array(relation_list['relation'])

    relations = forced_relations.map do |relation|
      PrepareBrainzDataService.call(brainz_data: relation)
    end

    result[key_name] = relations
    result
  end

  private

  def key_name
    "#{relation_list['target_type']}_relations"
  end

  # TODO: make :force_array a refinement
  def force_array(gizmo)
    return gizmo if gizmo.is_a? Array
    [gizmo]
  end
end

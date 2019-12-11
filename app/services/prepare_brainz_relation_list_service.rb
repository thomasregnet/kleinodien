# frozen_string_literal: true

# Take a MusicBrainz relation-list and return a hash with
# fitted key-name
class PrepareBrainzRelationListService < ServiceBase
  using RefineObjectForceArray

  def initialize(relation_list:)
    @relation_list = relation_list
  end

  attr_reader :relation_list

  def call
    { key_name => relations }
  end

  private

  def key_name
    "#{relation_list['target_type']}_relations"
  end

  def relations
    relation_list['relation'].force_array.map do |relation|
      PrepareBrainzDataService.call(brainz_data: relation)
    end
  end
end

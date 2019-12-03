# frozen_string_literal: true

# Convert MusicBrainz-Data to a more consumable data-structure
class PrepareBrainzDataService < ServiceBase
  def initialize(brainz_data:)
    @brainz_data = brainz_data
    @result      = {}
  end

  attr_reader :brainz_data, :result

  def call
    prepare_hash(brainz_data, result)
    result
  end

  private

  def prepare_hash(src, target = {})
    src.each { |key, value| target.merge!(prepare_pair(key, value)) }

    target
  end

  # This method smells of :reek:ManualDispatch
  def prepare_pair(key, value)
    method = "prepare_#{key}_key"

    return send(method, value) if respond_to?(method, true)
    return prepare_list(key, value) if key.ends_with?('_list')
    return { key => prepare_hash(value) } if value.class == Hash

    { key => value }
  end

  def prepare_length_key(value)
    { milliseconds: value.to_i }
  end

  def prepare_list(key, value)
    PrepareBrainzListService.call(key: key, value: value)
  end
end

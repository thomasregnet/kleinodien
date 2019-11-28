# frozen_string_literal: true

class PrepareBrainzDataService < ServiceBase
  def initialize(brainz_data:)
    @brainz_data = brainz_data
    @result      = {}
  end

  attr_reader :brainz_data, :result


  def call
    # result = {}
    # brainz_data.each do |key, value|
    #   prepared_key, prepared_value = prepare(key, value)
    #   result[prepared_key] = prepared_value
    # end
    prepare_hash(brainz_data, result)
    result
  end

  private

  # This method smells of :reek:ManualDispatch
  # Note that `respond_to?` is called  with `true` as second argument.
  # This is necessary because otherwise `respond_to?` does not find
  # private methods
  def prepare(key, value)
    method = "prepare_#{key}"
    return send(method, value) if respond_to?(method, true)
    # return prepare_hash(value, ) if value.class == Hash

    [key, value]
  end

  def prepare_hash(src, target = {})
    src.each do |key, value|
      target_key, target_value = prepare_pair(key, value)
      target[target_key] = target_value
    end

    target
  end

  # This method smells of :reek:ManualDispatch
  def prepare_pair(key, value)
    method = "prepare_#{key}"
    return send(method, value) if respond_to?(method, true)
    return [key, prepare_hash(value)] if value.class == Hash

    [key, value]
  end

  def prepare_length(value)
    [:milliseconds, value.to_i]
  end
end

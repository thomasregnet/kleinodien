# frozen_string_literal: true

class PrepareBrainzDataService < ServiceBase
  def initialize(brainz_data:)
    @brainz_data = brainz_data
  end

  attr_reader :brainz_data


  def call
    result = {}
    brainz_data.each do |key, value|
      prepared_key, prepared_value = prepare(key, value)
      result[prepared_key] = prepared_value
    end
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

    [key, value]
  end

  def prepare_length(value)
    [:milliseconds, value.to_i]
  end
end

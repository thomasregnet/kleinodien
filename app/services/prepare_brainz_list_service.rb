# frozen_string_literal: true

# Convert MusicBrainz *-list to an easy do use data-structure
class PrepareBrainzListService < ServiceBase
  def initialize(key:, value:)
    @key   = key
    @value = value
    @result = {}
  end

  attr_reader :key, :value, :result

  def call
    # [return_key, return_value]
    value.each do |key, value|
      next if key == item_name

      result[extra_key_for(key)] = value
    end
    result[return_key] = return_value
    result
  end

  private

  def extra_key_for(xxx)
    prefix = key.to_s.sub(/_list$/, '')
    "#{prefix}_#{xxx}"
  end

  def return_key
    item_name.pluralize
  end

  def return_value
    return map_to_brainz(considered_value) if considered_value.is_a? Array

    map_to_brainz([considered_value])
  end

  def map_to_brainz(values)
    values.map do |item|
      # PrepareBrainzDataService.call(brainz_data: item)
      itemize(item)
    end
  end

  def itemize(item)
    return item if item.is_a? String

    PrepareBrainzDataService.call(brainz_data: item)
  end

  def considered_value
    @considered_value ||= value[item_name]
  end

  def item_name
    @item_name ||= key.to_s.sub(/_list$/, '')
  end
end

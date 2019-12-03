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
    add_attributes
    result[enumeration_key] = enumeration
    result
  end

  private

  def add_attributes
    value.each do |given_key, value|
      next if given_key == item_name

      result[prefixed_attribute_for(given_key)] = value
    end
  end

  def attribute_prefix
    @attribute_prefix ||= key.to_s.sub(/_list$/, '')
  end

  def considered_value
    @considered_value ||= value[item_name]
  end

  def enumeration_key
    @enumeration_key ||= item_name.pluralize
  end

  def enumeration
    return map_to_brainz(considered_value) if considered_value.is_a? Array

    map_to_brainz([considered_value])
  end

  def item_name
    @item_name ||= key.to_s.sub(/_list$/, '')
  end

  def itemize(item)
    return item if item.is_a? String

    PrepareBrainzDataService.call(brainz_data: item)
  end

  def map_to_brainz(values)
    values.map do |item|
      # PrepareBrainzDataService.call(brainz_data: item)
      itemize(item)
    end
  end

  def prefixed_attribute_for(given_key)
    "#{attribute_prefix}_#{given_key}"
  end
end

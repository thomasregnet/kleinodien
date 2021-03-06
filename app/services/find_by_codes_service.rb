# frozen_string_literal: true

# Find entieies by codes from foreign data-sources such as MusicBrainz or TMDB
class FindByCodesService < ServiceBase
  def initialize(args)
    @model_class = args[:model_class]
    @codes_hash  = args[:codes_hash]
  end

  attr_reader :model_class, :codes_hash

  def call
    Rails.logger.info("try to find #{model_class} by codes")
    return if findable_codes.empty?

    opts = [query, params].flatten
    result = model_class.where(opts)
    return unless result

    result.first
  end

  def query
    columns = findable_codes.keys.map { |column| "#{column} = ?" }
    columns.join(' OR ')
  end

  def params
    findable_codes.values
  end

  def findable_codes
    CodesForModelService.call(
      codes_hash: codes_hash, model_class: model_class
    )
  end

  def model_codes
    model_class.column_names.select do |column_name|
      column_name.match?(/_code$/)
    end
  end

  def select_codes_hash
    codes_hash.select { |key, value| key.to_s.match?(/_code$/) && value }
  end
end

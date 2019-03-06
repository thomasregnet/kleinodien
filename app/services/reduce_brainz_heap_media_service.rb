# frozen_string_literal: true

# Reduce Media to it's formats
class ReduceBrainzHeapMediaService
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint    = args[:blueprint]
    @import_order = args[:import_order]
    @last_code    = ''
    @result       = []
  end

  attr_reader :blueprint, :import_order, :last_code, :result

  def call
    reduce && result
  end

  def reduce
    blueprint.each do |medium|
      brainz_format_code = medium.format.brain_code
      if brainz_format_code == last_code
        result.last[:quantity] += 1
      else
        add(medium)
      end

      @last_code = brainz_format_code
    end
  end

  def add(medium)
    result << {
      medium_format: find_or_create_medium_format(medium),
      quantity:      1
    }
  end

  # This method smells of :reek:FeatureEnvy
  # This method smells of :reek:TooManyStatements
  def find_or_create_medium_format(medium)
    given_format = medium.format
    brainz_code  = given_format.brainz_code

    MediumFormat.find_or_create_by!(brainz_code: brainz_code) do |new_format|
      new_format.brainz_code  = brainz_code
      new_format.import_order = import_order
      new_format.name         = given_format.__content__
    end
  end
end

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
    blueprint.each do |medium|
      brainz_format_code = medium.format.brain_code
      if brainz_format_code == last_code
        result.last[:quantity] += 1
      else
        find_or_create_medium_format(medium)
      end
    end

    result
  end

  def find_or_create_medium_format(medium)
    medium_format = medium.format

    # TODO: use find_or_create
    result << MediumFormat.find_by(brainz_code: medium_format.id)
    {
      medium_format: medium_format,
      name:          medium_format.__content__,
      quantity:      1
    }
  end
end

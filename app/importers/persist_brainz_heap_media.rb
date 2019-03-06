# frozen_string_literal: true

# Media of a Heap
class PersistBrainzHeapMedia < PersistBrainzBase
  def initialize(args)
    super(args)
    @blueprint = args[:blueprint]
    @heap      = args[:heap]
  end

  attr_reader :blueprint, :heap

  def call
    persist
  end

  def persist
    quantities.each.with_index(1) do |quantity, position|
      heap.media.create!(
        heap:     heap,
        position: position,
        quantity: quantity[:quantity],
        format:   quantity[:medium_format]
      )
    end
  end

  def quantities
    last_code = ''
    result = []

    blueprint.each do |medium|
      brainz_format_code = medium.format.id
      if brainz_format_code == last_code
        result.last[:quantity] += 1
      else
        result << {
          medium_format: medium_format_for(brainz_format_code),
          name:          medium.format.__content__,
          quantity:     1
        }
      end
    end

    result
  end

  def medium_format_for(brainz_format_code)
    # TODO: find_or_create instead of find_by
    MediumFormat.find_by(brainz_code: brainz_format_code)
  end
end

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

  # This method smells of :reek:TooManyStatements
  def quantities
    last_code = ''
    result = []

    blueprint.map do |medium|
      brainz_format_code = medium.format.id
      if brainz_format_code == last_code
        result.last[:quantity] += 1
      else
        result << create_medium(medium)
      end

      last_code = brainz_format_code
    end

    result
  end

  # This method smells of :reek:UtilityFunction
  def create_medium(medium)
    medium_format = medium.format
    format = MediumFormat.find_by(brainz_code: medium_format.id)
    {
      medium_format: format,
      name:          medium_format.__content__,
      quantity:      1
    }
  end
end

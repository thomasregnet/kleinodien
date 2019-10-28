# frozen_string_literal: true

# Persist an AreaAlias retrieved from brainz
class PersistBrainzAreaAlias < PersistPrepareBase
  BRAINZ_AREA_ALIAS_TYPE_FOR = {
    'Area name'   => 'AreaNameAlias',
    'Formal name' => 'AreaFormalNameAlias',
    'Search hint' => 'AreaSearchHint'
  }.freeze

  def initialize(area:, blueprint:)
    # super(args)
    @area      = area
    @blueprint = blueprint
  end

  attr_reader :area, :blueprint

  def call
    area_alias = AreaAlias.new(
      area:      area,
      name:      blueprint.__content__,
      sort_name: blueprint.sort_name,
      locale:    blueprint.locale,
      type:      alias_type
    )

    area_alias.begin_date = begin_date if begin_date?
    area_alias.end_date = end_date if end_date?

    area_alias.save!
  end

  private

  def alias_type
    type = BRAINZ_AREA_ALIAS_TYPE_FOR[blueprint.type]
    return type if type

    Rails.logger.warn("unknown AreaAlias-type: #{type}")

    nil
  end

  def begin_date
    return unless begin_date?

    IncompleteDate.from_string(blueprint.begin_date)
  end

  def begin_date?
    true if blueprint.begin_date
  end

  def end_date
    return unless end_date?

    IncompleteDate.from_string(blueprint.end_date)
  end

  def end_date?
    true if blueprint.end_date
  end
end

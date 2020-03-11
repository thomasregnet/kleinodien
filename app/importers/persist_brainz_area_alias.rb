# frozen_string_literal: true

# Persist an AreaAlias retrieved from brainz
class PersistBrainzAreaAlias < PersistPrepareBase
  BRAINZ_AREA_ALIAS_TYPE_FOR = {
    'Area name'   => 'AreaNameAlias',
    'Formal name' => 'AreaFormalNameAlias',
    'Search hint' => 'AreaSearchHint'
  }.freeze

  def initialize(area:, blueprint:, **args)
    super(args)
    @area      = area
    @blueprint = blueprint
  end

  attr_reader :area, :blueprint

  def call
    AreaAlias.create!(
      area:       area,
      name:       blueprint.__content__,
      begin_date: blueprint.incomplete_begin_date,
      end_date:   blueprint.incomplete_end_date,
      sort_name:  blueprint.sort_name,
      locale:     blueprint.locale,
      type:       alias_type
    )
  end

  private

  def alias_type
    blueprint_type = blueprint.type || return

    type = BRAINZ_AREA_ALIAS_TYPE_FOR[blueprint_type]
    return type if type

    Rails.logger.warn("unknown AreaAlias-type: #{blueprint_type}")

    nil
  end
end

# frozen_string_literal: true

# Persist an Area retrieved from MusicBrainz
class PersistBrainzArea < PersistBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @blueprint = blueprint
  end

  attr_reader :blueprint

  def call
    find_already_existing || persist
  end

  def find_already_existing
    Area.find_by(brainz_code: blueprint.brainz_code) \
      || Area.find_by(name: blueprint.name)
  end

  # TODO: Safer mechanism to determinate the "type"
  # TODO: also persist ImportOrder
  def persist
    area = Area.create!(
      name:        brainz_area.name,
      sort_name:   brainz_area.sort_name,
      brainz_code: brainz_area.brainz_code,
      type:        brainz_area.type
    )

    persit_iso(area)
    persist_aliases(area)
  end

  def persit_iso(area)
    # TODO: implement persist_iso
  end

  # This method smells of :reek:FeatureEvy
  def persist_aliases(area)
    aliases = brainz_area.aliases || return
    aliases.each do |area_alias|
      PersistBrainzAreaAlias.call(area: area, blueprint: area_alias)
    end
  end

  def brainz_area
    @brainz_area = proxy.get(import_request)
  end

  def import_request
    @import_request ||= BrainzAreaImportRequest.create(
      code: blueprint.brainz_code
    )
  end
end

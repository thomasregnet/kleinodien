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

  def persist
    area = Area.create!(
      name:        brainz_area.name,
      sort_name:   brainz_area.sort_name,
      brainz_code: brainz_area.brainz_code
    )

    persit_iso(area)
    persist_aliases(area)
  end

  def persit_iso(area)
    # TODO: implement persist_iso
  end

  def persist_aliases(area)
    # TODO: implement persit_aliases
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

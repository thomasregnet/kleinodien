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
    persit_iso
    persist_aliases

    area
  end

  def persit_iso
    [1, 2, 3].each do |iso_num|
      codes = blueprint.send("iso_3166_#{iso_num}_codes") || next
      persist_iso_codes(codes, iso_num)
    end
  end

  def persist_iso_codes(codes, iso_num)
    iso_class = "Iso3166Part#{iso_num}Country".constantize

    codes.each do |code|
      iso_class.create!(area: area, code: code)
    end
  end

  def persist_aliases
    aliases = brainz_area.aliases || return
    aliases.each do |area_alias|
      PersistBrainzAreaAlias.call(area: area, blueprint: area_alias)
    end
  end

  def brainz_area
    @brainz_area ||= proxy.new_get(:area, blueprint.brainz_code)
  end

  private

  def area
    @area ||= Area.create!(
      import_order: import_order,
      name:         brainz_area.name,
      sort_name:    brainz_area.sort_name,
      brainz_code:  brainz_area.brainz_code,
      type:         brainz_area.type
    )
  end
end

# frozen_string_literal: true

# Peisist a MusicBrainz release-event
class PersistBrainzReleaseEvent < PersistBrainzBase
  def initialize(blueprint:, release:, **args)
    super(args)
    @blueprint = blueprint
    @release   = release
  end

  attr_reader :blueprint, :release

  def call
    ReleaseEvent.create!(
      area:    area,
      date:    date,
      release: release
    )
  end

  private

  def area
    PersistBrainzArea.call(
      blueprint:    blueprint.area,
      import_order: import_order,
      proxy:        proxy
    )
  end

  def date
    date_string = blueprint.date || return
    IncompleteDate.from_string(date_string)
  end
end

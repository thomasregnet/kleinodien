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
    Rails.logger.info('persisting Brainz Release Event')
    ReleaseEvent.create!(
      area:    area,
      date:    date,
      release: release
    )
  end

  private

  def area
    Rails.logger.info("persisting Brainz area #{blueprint.area.brainz_code}")
    persist_area(code: blueprint.area.brainz_code)
  end

  def date
    date_string = blueprint.date || return
    IncompleteDate.from_string(date_string)
  end
end

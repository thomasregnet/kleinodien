# frozen_string_literal: true

# Find an Area by name either on areas or an iso3166_?-code
class FindAreaByNameService < ServiceBase
  def initialize(name:)
    @name = name
  end

  attr_reader :name

  def call
    from_area || by_iso_3166_1_code || by_iso_3166_2_code || by_iso_3166_3_code
  end

  def from_area
    Area.find_by(name: name)
  end

  def by_iso_3166_1_code
    return unless name.length == 2

    Area.joins(:iso3166_part1_countries)
        .where(iso3166_part1_countries: { code: name })
        .limit(1).first
  end

  def by_iso_3166_2_code
    return unless name.length.between?(4, 6)

    Area.joins(:iso3166_part2_countries)
        .where(iso3166_part2_countries: { code: name })
        .limit(1).first
  end

  def by_iso_3166_3_code
    return unless name.length == 4

    Area.joins(:iso3166_part3_countries)
        .where(iso3166_part3_countries: { code: name })
        .limit(1).first
  end
end

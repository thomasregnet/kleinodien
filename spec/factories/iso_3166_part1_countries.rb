# frozen_string_literal: true

def iso_3166_1_code_factory
  @iso_3166_1_code_factory ||= ('AA'..'ZZ').to_a
end

FactoryBot.define do
  factory :iso3166_part1_country do
    association :area, factory: :area
    sequence(:code) { iso_3166_1_code_factory.shift }
  end
end

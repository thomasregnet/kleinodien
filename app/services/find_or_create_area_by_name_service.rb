# frozen_string_literal: true

# Find an Area by name either on areas or an iso3166_?-code or create it
class FindOrCreateAreaByNameService < ServiceBase
  def initialize(name:)
    @name = name
  end

  attr_reader :name

  def call
    find || create
  end

  private

  def find
    FindAreaByNameService.call(name: name)
  end

  def create
    Area.create(name: name)
  end
end

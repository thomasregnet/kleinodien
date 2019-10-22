# frozen_string_literal: true

# Find an Area by name either on areas or an iso3166_?-code or create it
class FindOrCreateAreaByNameService < ServiceBase
  def initialize(name:, import_order: nil)
    @import_order = import_order
    @name         = name
  end

  attr_reader :import_order, :name

  def call
    find || create
  end

  private

  def find
    FindAreaByNameService.call(name: name)
  end

  def create
    Area.create(name: name, import_order: import_order)
  end
end

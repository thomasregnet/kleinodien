# frozen_string_literal: true

# Prepare an Area
class PrepareBrainzArea < PrepareBrainzBase
  def initialize(stub:, **args)
    super(args)
    @stub = stub
  end

  attr_reader :stub

  def code
    stub.brainz_code
  end

  def prepare
    return if proxy.cached?(:area, code)
    return if Area.where(brainz_code: code).or(Area.where(name: stub.name)).any?

    proxy.get(:area, code)
  end

  # def prepare
  #   find_already_existing || trigger_proxy
  # end

  # def find_already_existing
  #   find_by_brainz_code || find_by_name
  # end

  # def find_by_brainz_code
  #   Area.find_by(brainz_code: blueprint.brainz_code)
  # end

  # def find_by_name
  #   Area.find_by(name: blueprint.name)
  # end

  # def trigger_proxy
  #   proxy.get(:area, blueprint.brainz_code)
  # end
end

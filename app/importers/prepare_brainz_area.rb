# frozen_string_literal: true

# Prepare an Area
class PrepareBrainzArea < PrepareBrainzBase
  def initialize(stub:, **args)
    super(**args)
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
end

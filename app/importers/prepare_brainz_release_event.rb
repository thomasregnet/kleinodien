# frozen_string_literal: true

# Prepare a ReleaseEvent of a Release
class PrepareBrainzReleaseEvent < PrepareBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @blueprint = blueprint
  end

  attr_reader :blueprint

  def prepare
    prepare_area(stub: blueprint.area)
  end
end

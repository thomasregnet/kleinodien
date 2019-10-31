# frozen_string_literal: true

# Prepare a ReleaseEvent of a Release
class PrepareBrainzReleaseEvent < PrepareBrainzBase
  def initialize(blueprint:, **args)
    super(args)
    @blueprint = blueprint
  end

  attr_reader :blueprint

  def prepare
    PrepareBrainzArea.call(
      blueprint:    blueprint.area,
      import_order: import_order,
      proxy:        proxy
    )
  end
end

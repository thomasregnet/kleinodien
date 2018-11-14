# frozen_string_literal: true

# Import a Release from MusicBrainz
class ImportBrainzRelease
  def self.call(import_order)
    new(import_order).call
  end

  def initialize(import_order)
    @import_order = import_order
  end

  attr_reader :import_order

  def call
    import_request = TransformBrainzOrderToRequestService.call(
      expected_kind: :release,
      import_order:  import_order
    )

    proxy = BrainzProxy.new
    PrepareBrainzRelease.call(
      import_request: import_request,
      proxy:          proxy
    )
  end
end

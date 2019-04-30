# frozen_string_literal: true

# Base class for MusicBrainz importers
class ImportBrainzBase < ImportBase
  def import_request
    @import_request ||= TransformBrainzOrderToRequestService.call(
      import_order: import_order
    )
  end

  def proxy
    @proxy ||= BrainzProxy.new(import_order: import_order)
  end
end

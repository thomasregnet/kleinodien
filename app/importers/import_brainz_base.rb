# frozen_string_literal: true

# Base class for MusicBrainz importers
class ImportBrainzBase < ImportBase
  def proxy
    @proxy ||= BrainzProxy.new(import_order: import_order)
  end
end

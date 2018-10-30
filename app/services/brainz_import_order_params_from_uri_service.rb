# frozen_string_literal: true

# Takes an uri and returns the ImportOrder parmeters code and kind
class BrainzImportOrderParamsFromUriService < ImportOrderParamsFromUriService
  def offset
    return unless path_string

    return 2 if path_string =~ %r{^ws/2/}

    0
  end
end

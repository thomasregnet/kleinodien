# frozen_string_literal: true

require_relative '../../lib/fake_proxy'

class LockingFakeProxy < FakeProxy
  def get(what, code)
    if locked? && !cached?(what, code)
      raise(
        ImportError::ProxyLocked,
        "Proxy is locked but #{import_request.to_uri} is  not cached"
      )
    end

    super(what, code)
  end
end

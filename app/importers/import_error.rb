# frozen_string_literal: true

module ImportError
  # When an entity already exists in the database
  class AlreadyExists < RuntimeError
  end

  # When data can't be received
  class CanNotFetch < RuntimeError
  end

  # When a Proxy is locked and the requested data is not cached
  class ProxyLocked < RuntimeError
  end
end

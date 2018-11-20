module ImportError
  # When an entity already exists in the database
  class AlreadyExists < RuntimeError
  end

  # When data can't be received
  class CanNotFetch < RuntimeError
  end
end

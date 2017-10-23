module Import
  # Base class for import exceptions
  class Exception < RuntimeError
    def status
      500
    end

    def render
      {}
    end
  end
end

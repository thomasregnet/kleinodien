module Import
  # Base class for import exceptions
  class Exception < RunntimeError
    def status
      500
    end

    def render
      {}
    end
  end
end

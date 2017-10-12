# Base class for import exceptions
class ImportException < RunntimeError
  def status
    500
  end

  def render
    {}
  end
end

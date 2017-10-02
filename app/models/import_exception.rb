class ImportException < Exception
  def status
    500
  end

  def render
    {}
  end
end

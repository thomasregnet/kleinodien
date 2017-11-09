# Base class for external references
class Reference
  attr_reader :code, :kind, :query_string

  def initialize(args)
    @code =         args[:code]
    @kind =         args[:kind]
    @query_string = args[:query_string]
  end

  def to_key
    "#{kind}/#{code}" + ( query_string ? query_string : '' )
  end
end

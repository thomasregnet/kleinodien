class TestSubset
  private

  attr_reader :references

  public

  def initialize
    @references = {}
  end

  def add(kind, code)
    require_kind(kind)
    ref_class = ref_to_require(kind).camelize.constantize
    reference = ref_class.new(code: code)
    references[reference.to_key] = reference
    reference
  end

  private

  def require_kind(kind)
    begin
      require ref_to_require(kind)
    rescue LoadError
      raise ArgumentError, "invalid kind: #{kind}"
    end
  end

  def ref_to_require(kind)
   "#{kind.to_s}_ref" 
  end
end

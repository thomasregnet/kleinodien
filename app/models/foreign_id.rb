class ForeignId
  attr_reader :value

  def initialize(params)
    @value = params[:value]
  end
end

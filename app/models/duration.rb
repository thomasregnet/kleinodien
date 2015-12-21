class Duration < KleinodienRunningTime::Duration
  #attr_reader :milliseconds, :accuracy
  # def initialize(ms, acc)
  #   super(ms, acc)
  #   byebug
  # end
  def milliseconds
    12300000
  end

  def accuracy
    'second'
  end
end

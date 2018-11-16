class ForceArrayOfObjectsService
  include CallWithArgs

  private

  attr_reader :klass, :value

  def initialize(args)
    @klass = args[:klass]
    @value = args[:value]
  end

  def private_call
    return unless value
    # byebug
    if value.is_a? Array
      value.map do |args|
        klass.new(args)
      end
    else
      [klass.new(value)]
    end
  end
end

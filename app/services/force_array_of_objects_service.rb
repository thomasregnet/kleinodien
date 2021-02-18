# frozen_string_literal: true

# Return an Array of Objects of a given class
class ForceArrayOfObjectsService < ServiceBase
  def initialize(klass:, value:)
    super()
    @klass = klass
    @value = value
  end

  attr_reader :klass, :value

  def call
    return unless value

    if value.is_a? Array
      value.map do |args|
        klass.new(args)
      end
    else
      [klass.new(value)]
    end
  end
end

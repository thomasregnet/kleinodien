class FindByCodesService
  include CallWithArgs

  private

  attr_reader :model_class, :attributes

  def initialize(args)
    @model_class = args[:model_class]
    @attributes  = args[:attributes]
  end

  def private_call
    return unless findable_codes
    # model_class.find_by(findable_codes)
    # byebug
    opts = [query, params].flatten
    # model_class.where(query, params)
    model_class.where(opts)
  end

  def query
    columns = findable_codes.keys.map { |column| "#{column} = ?" }
    columns.join(' OR ')
  end

  def params
    findable_codes.values
  end

  def findable_codes
    model_codes = model_class.column_names.select do |attr|
      attr.match?(/_code$/)
    end

    code_attributes.select { |key, _| model_codes.include? key.to_s }
  end

  def code_attributes
    attributes.select { |key, value| key.to_s.match?(/_code$/) && value }
  end
end

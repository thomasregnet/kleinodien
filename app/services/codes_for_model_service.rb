# frozen_string_literal: true

# Extract the codes useable by a model_class from a codes_hash
# Optional merge the codes with a given hash
class CodesForModelService < ServiceBase
  def initialize(codes_hash:, model_class:, given: {})
    @codes_hash  = codes_hash
    @given       = given
    @model_class = model_class
  end

  attr_reader :codes_hash, :given, :model_class

  def call
    codes = codes_hash.select { |key, _| common_codes.include?(key) }
    ActiveSupport::HashWithIndifferentAccess.new(codes.merge(given))
  end

  private

  def common_codes
    filtered_codes.keys & model_codes
  end

  # This method smells of :reek:NilCheck
  def filtered_codes
    codes_hash.reject { |_, value| value.nil? }
  end

  def model_codes
    model_class.column_names.grep(/.+code$/)
  end
end

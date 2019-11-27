# frozen_string_literal: true

# Extract the codes useable by a model_class from a codes_hash
# Optional merge the codes with a given hash
class CodesForModelService < ServiceBase
  def initialize(codes_hash:, model_class:, given: {})
    @codes_hash  = codes_hash.with_indifferent_access
    @given       = given
    @model_class = model_class
  end

  attr_reader :codes_hash, :given, :model_class

  def call
    codes = {}
    common_codes.each do |code_key|
      codes[code_key] = codes_hash[code_key]
    end
    codes.merge(given).with_indifferent_access
  end

  private

  def common_codes
    model_codes.select { |code| filtered_codes.include?(code) }
  end

  # This method smells of :reek:NilCheck
  def filtered_codes
    @filtered_codes ||= codes_hash.reject { |_, value| value.nil? }
                                  .with_indifferent_access
  end

  def model_codes
    model_class.column_names.grep(/.+_code$/)
  end
end

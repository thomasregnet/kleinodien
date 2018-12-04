# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_test_data_results'
require 'test_data/result_base'

# Mock the #blueprint-method to use the shared examples
class TestData::MockResultBaseBlueprint < TestData::ResultBase
  def blueprint
    raw
  end
end

RSpec.describe TestData::MockResultBaseBlueprint do
  it_behaves_like 'a test-data result', 'a test string', String
  # context 'when initialized with a string' do
  #   def string
  #     'a test string'
  #   end

  #   let(:result) { described_class.new(string) }

  #   describe '#raw' do
  #     it 'returns the given string' do
  #       expect(result.raw).to eq string
  #     end
  #   end

  #   describe '#to_s' do
  #     it 'returns the raw string' do
  #       expect(result.to_s).to eq string
  #     end
  #   end
  # end
end

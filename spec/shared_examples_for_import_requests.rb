# frozen_string_literal: true

RSpec.shared_examples 'for ImportRequests' do |model|
  context 'with valid parameters' do
    let(:import_request) { FactoryBot.build(model) }

    it 'is valid' do
      expect(import_request).to be_valid
    end
  end

  # context 'without a code' do
  #   let(:import_request) { FactoryBot.build(model, code: nil) }

  #   it 'is not valid' do
  #     expect(import_request).not_to be_valid
  #   end
  # end

  # it { is_expected.to respond_to(:to_json).with(0).arguments }

  # it 'is not valid without a code' do
  #   byebug
  #   expect(described_class.new).not_to be_valid
  # end

  # it 'is valid with a code' do
  #   expect(described_class.new(code: 'abc')).to be_valid
  # end

  # it 'has the importer_class set' do
  #   expect(described_class.new.importer_class).not_to be_nil
  # end

  # it 'has the reference_class set' do
  #   expect(described_class.new.reference_class).not_to be_nil
  # end
end

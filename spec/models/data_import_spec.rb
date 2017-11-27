require 'rails_helper'

RSpec.describe DataImport, type: :model do
  it 'is valid with valid parameters' do
    expect(FactoryGirl.build(:data_import)).to be_valid
  end

  it { is_expected.to(have_many(:artists)) }

  context 'without a note' do
    let(:data_import) { described_class.new }

    it 'is not valid' do
      expect(data_import).not_to be_valid
    end

    it 'raises an exception' do
      expect { data_import.save! validate: false }
        .to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end

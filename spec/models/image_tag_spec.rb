# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageTag, type: :model do
  subject { FactoryBot.create(:image_tag) }

  it { should have_and_belong_to_many(:release_images) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }

  describe '.find_or_create_by_name' do
    context 'when there is no such tag' do
      it 'creates that tag' do
        expect(described_class.find_or_create_by_name('my_tag')).to be_instance_of(described_class)
      end
    end

    context 'when the tag is already stored in the database' do
      it 'returns that tag' do
        tag = described_class.create(name: 'my_tag')
        expect(described_class.find_or_create_by_name('my_tag')).to eq(tag)
      end
    end

    context 'when the tag is already stored in the table using an alternative spelling' do
      it 'returns that tag' do
        tag = described_class.create(name: 'my_tag')
        expect(described_class.find_or_create_by_name('My_Tag')).to eq(tag)
      end
    end
  end
end

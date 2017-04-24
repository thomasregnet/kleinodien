require 'rails_helper'
require 'shared_examples_for_unique_names'

RSpec.describe Country, type: :model do
  specify '#descriptions' do
    expect(subject).to respond_to(:descriptions)
  end

  it_behaves_like 'an entity with an unique name' do
    let(:candidate) { FactoryGirl.build(:country) }
  end
end

require 'rails_helper'
require 'shared_examples_for_unique_names'

RSpec.describe Job, type: :model do
  it_behaves_like 'an entity with an unique name' do
    let(:candidate) { FactoryBot.build(:job) }
  end
end

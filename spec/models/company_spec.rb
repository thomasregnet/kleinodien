require 'rails_helper'
require 'shared_examples_for_unique_names'

RSpec.describe Company, type: :model do
  it_behaves_like "an entity with an unique name" do
    let(:factory) { :company }
  end
end

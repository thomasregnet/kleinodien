require 'rails_helper'
require 'shared_examples_for_references'

RSpec.describe PrReference, type: :model do
  it_behaves_like 'a reference' do
    let(:class_name) { PrReference }
  end
end

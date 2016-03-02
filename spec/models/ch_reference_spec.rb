require 'rails_helper'
require 'shared_examples_for_references'

RSpec.describe ChReference, type: :model do
  it_behaves_like 'a reference' do
    let(:class_name) { ChReference }
  end
end

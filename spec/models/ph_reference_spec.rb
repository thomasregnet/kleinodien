require 'rails_helper'
require 'shared_examples_for_references'

RSpec.describe PhReference, type: :model do
  it_behaves_like 'a reference' do
    let(:class_name) { PhReference }
  end
end

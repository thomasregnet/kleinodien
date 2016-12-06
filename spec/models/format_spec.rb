require 'rails_helper'
require 'shared_examples_for_formats'

RSpec.describe Format, type: :model do
  before(:each) do
    @format = FactoryGirl.build(:format)
  end

  it_behaves_like 'a format' do
    let(:format) { @format }
  end
end

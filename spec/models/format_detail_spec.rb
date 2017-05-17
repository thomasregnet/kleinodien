require 'rails_helper'
require 'shared_examples_for_formats'

RSpec.describe FormatDetail, type: :model do
  before(:each) do
    @format_detail = FactoryGirl.build(:format_detail)
  end

  it_behaves_like 'a format' do
    # byebug
    let(:format) { @format_detail }
  end
end

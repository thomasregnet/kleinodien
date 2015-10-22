require 'rails_helper'

RSpec.describe SourceIdentifier, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @src_ident = FactoryGirl.create(:source_identifier)
  end

  it 'is valid with valid attributes' do
    expect(@src_ident).to be_valid
  end
end

require 'rails_helper'

RSpec.describe "release_copies/new", type: :view do
  let(:release_copy) { FactoryBot.build(:release_copy) }
  let(:release) { FactoryBot.build(:release) }

  before do
    assign(:release_copy, release_copy) 
    assign(:release, release)

    allow(release).to receive(:id).and_return(123)
  end

  it "renders new release_copy form" do
    render

    assert_select 'form[action=?][method=?]', release_copies_path, 'post' do
      assert_select 'select[name=?]', 'release_copy[type]'
    end
  end
end

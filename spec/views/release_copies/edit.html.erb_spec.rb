require 'rails_helper'

RSpec.describe "release_copies/edit", type: :view do
  let(:release_copy) { FactoryBot.create(:release_copy) }

  before { assign(:release_copy, release_copy) }

  it "renders the edit release_copy form" do
    render

    assert_select 'form[action=?][method=?]', release_copy_path(release_copy), 'post' do
      assert_select 'select[name=?]', 'release_copy[type]'
    end
  end
end

require 'rails_helper'

RSpec.describe "release_copies/new", type: :view do
  let(:release_copy) { FactoryBot.build(:release_copy) }

  before { assign(:release_copy, release_copy) }

  it "renders new release_copy form" do
    render

    assert_select 'form[action=?][method=?]', release_copies_path, 'post' do
      assert_select 'textarea[name=?]', 'release_copy[type]'
      assert_select 'input[name=?]', 'release_copy[release_head_id]'
      assert_select 'input[name=?]', 'release_copy[release_id]'
      assert_select 'input[name=?]', 'release_copy[user_id]'
    end
  end
end

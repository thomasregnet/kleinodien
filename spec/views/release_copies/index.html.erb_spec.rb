require 'rails_helper'

RSpec.describe "release_copies/index", type: :view do
  # before { assign(:release_copies, FactoryBot.create_list(:release_copy, 2)) }
  before do
    FactoryBot.create_list(:release_copy, 2)
    release_copies = ReleaseCopy.all.page
    assign(:release_copies, release_copies)
  end

  it 'renders a list of release_copies' do
    render
    expect(rendered).to match(%r{<td>\d+</td>})
    # assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    ### assert_select 'tr>td', text: nil.to_s, count: 4
    # assert_select 'tr>td', text: nil.to_s, count: 2
    # assert_select 'tr>td', text: nil.to_s, count: 2
  end
end

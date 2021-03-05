# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'create a ReleaseHead' do
  before do
    login_as(FactoryBot.create(:user))
    visit new_release_head_path
  end

  scenario 'with valid inputs' do
    fill_in 'Title', with: 'My head'
    click_on 'Create Release head'

    expect(page).to have_content('Release head was successfully created')
  end

  scenario 'with invalid inputs' do
    click_on 'Create Release head'

    expect(page).to have_content("Title can't be blank")
  end
end

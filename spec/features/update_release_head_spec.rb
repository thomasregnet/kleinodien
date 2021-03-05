# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'update a ReleaseHead' do
  before do
    login_as(FactoryBot.create(:user))
    release_head = FactoryBot.create(:release_head)
    visit edit_release_head_path(release_head)
  end

  scenario 'with valid parameters' do
    fill_in 'Title', with: 'My release'
    click_on('Update Release head')

    expect(page).to have_content('Release head was successfully updated')
  end

  scenario 'with invalid parameters' do
    fill_in 'Title', with: ''
    click_on('Update Release head')

    expect(page).to have_content("Title can't be blank")
  end
end

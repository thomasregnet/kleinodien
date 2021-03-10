# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'create a release' do
  before do
    login_as(FactoryBot.create(:user, curator: true))
    release = FactoryBot.create(:release)
    visit edit_release_path(release)
  end

  scenario 'with valid inputs' do
    fill_in 'Title', with: 'Aftershock'
    click_on 'Update Release'

    expect(page).to have_content('Release was successfully updated')
  end

  scenario 'with invalid inputs' do
    fill_in 'Release head', with: ''
    click_on 'Update Release'

    expect(page).to have_content('Head must exist')
  end
end

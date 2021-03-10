# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'create a release' do
  let(:release_head) { FactoryBot.create(:release_head) }

  before do
    login_as(FactoryBot.create(:user, curator: true))
    visit new_release_path
  end

  scenario 'with valid inputs' do
    fill_in 'Release head', with: release_head.id
    click_on 'Create Release'

    expect(page).to have_content('Release was successfully created.')
  end

  scenario 'with invalid inputs' do
    click_on 'Create Release'

    expect(page).to have_content('Head must exist')
  end
end

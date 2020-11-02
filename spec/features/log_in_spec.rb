# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'log in', type: :feature do
  # Testing log out does not work with capybara
  # Error message:
  #   No route matches [DELETE] "/users/sign_out"
  # https://stackoverflow.com/questions/19530560/cucumber-with-capybara-rack-test-not-working-with-delete-route

  scenario 'log in' do
    FactoryBot.create(:user, email: 'test@example.com', password: 'topSecret')

    visit '/'
    click_link('Log in')
    fill_in('user[email]', with: 'test@example.com')
    fill_in('user[password]', with: 'topSecret')
    click_button('Log in')

    expect(page).to have_content('Signed in successfully.')
  end
end

Given(/^I have not signed up$/) do
  # TODO: how to test that an user has not signed up?
end

When(/^I visit the sign\-up\-path$/) do
  visit 'users/sign_up'
end

When(/^I fill in appropriate values for email and password$/) do
  password = 'topSecret'
  fill_in 'Email', with: 'foo@example.com'
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password
end

When(/^I press the Sign up Button$/) do
  click_button 'Sign up'
end

Then(/^I should see "(.*?)"$/) do |arg1|
  expect(page).to have_content 'signed up successfully'
end

Then(/^I should see the logout link$/) do
  expect(page).to have_link 'Sign out'
end

Given(/^User exists$/) do
  @user = FactoryGirl.create(:user)
end

When(/^I visit the Sign in page$/) do
  visit 'users/sign_in'
end

When(/^I Fill in email and password$/) do
  fill_in 'Email',    with: @user.email
  fill_in 'Password', with: @user.password
  click_button('Log in')
end

Then(/^I should see success$/) do
  expect(page).to have_content 'Signed in successfully'
end


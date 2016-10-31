
When(/^I visit the repositories page$/) do
  visit repositories_path
end

When(/^I click the link to create a new repository$/) do
  click_link 'create a new repository'
end

When(/^I fill in a repository name$/) do
  fill_in 'repository_name', with: 'my new repository'
end

When(/^I press the create button$/) do
  click_button 'create'
end

When(/^I choose "([^"]*)" as format$/) do |f_name|
  select 'CDr', from: 'repository_re_format_name'
end

Then(/^I will see the my new repository$/) do
  expect(page).to have_content @my_repository_name
end


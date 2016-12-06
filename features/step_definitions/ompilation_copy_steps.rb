Then(/^I follow the link 'add to collection'$/) do
  click_link 'add to collection'
end

Then(/^I fill in a explanation$/) do
  fill_in 'Note', with: 'my very first copy'
end

Then(/^I will see the CompilationCopy$/) do
  expect(page).to have_content 'my very first copy'
end

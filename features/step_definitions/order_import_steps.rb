# include Devise::Test::IntegrationHelpers

When("I visit the import_orders page") do
  visit new_import_order_path
end


When("I fill in an suitable url") do
  fill_in(
   'Uri',
    with: 'https://musicbrainz.org/release/9424ad78-73f1-4148-aac5-cbff55652e22'
  )
end

When("I click the import button") do
  click_button 'Submit'
end

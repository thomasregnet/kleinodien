Given("The Artist with {string} {string}") do |column_name, code|
  @model       = Artist
  @column_name = column_name
  @code        = code

  FactoryBot.create(:artist, column_name=> code)
end

When("I call Model#find_by_codes") do
  @result = @model.find_by_codes(@column_name => @code)
end

Then("I get this model") do
  expect(@result).to be_instance_of(@model)
end

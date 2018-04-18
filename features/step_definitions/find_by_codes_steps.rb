# frozen_string_literal: true

def code_for(code_key)
  case code_key
  when 'brainz_code'
    SecureRandom.uuid
  else
    Random.rand(999)
  end
end

Given("The Artist with {string} exists") do |code_key|
  @model    = Artist
  @code_key = code_key
  @code     = code_for(code_key)

  FactoryBot.create(:artist, code_key=> @code)
end

Given("The CompilationHead with {string} exists") do |code_key|
  @model    = CompilationHead
  @code_key = code_key
  @code     = code_for(code_key)

  FactoryBot.create(:compilation_head, code_key => @code)
end

Given("The CompilationRelease with {string} exists") do |code_key|
  @model    = CompilationRelease
  @code_key = code_key
  @code     = code_for(code_key)

  FactoryBot.create(:compilation_release, code_key => @code)
end

Given("The PieceHead with {string} exists") do |code_key|
  @model    = PieceHead
  @code_key = code_key
  @code     = code_for(code_key)

  FactoryBot.create(:piece_head, code_key => @code)
end

Given("The PieceRelease with {string} exists") do |code_key|
  @model    = PieceRelease
  @code_key = code_key
  @code     = code_for(code_key)

  FactoryBot.create(:piece_release, code_key => @code)
end

Given("The Season with {string} exists") do |code_key|
  @model    = Season
  @code_key = code_key
  @code     = code_for(code_key)

  FactoryBot.create(:season, code_key => @code)
end

Given("The Serial with {string} exists") do |code_key|
  @model    = Serial
  @code_key = code_key
  @code     = code_for(code_key)

  FactoryBot.create(:serial, code_key => @code)
end

When("I call Model#find_by_codes") do
  @result = @model.find_by_codes(@code_key => @code)
end

Then("I get this model") do
  expect(@result).to be_instance_of(@model)
end

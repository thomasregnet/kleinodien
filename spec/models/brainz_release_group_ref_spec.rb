require "rails_helper"

RSpec.describe BrainzReleaseGroupRef do
  before(:all) do
    @foreign_id = BrainzReleaseGroupRef.new(value: uuid)
  end

  def uuid
    '5fc9ba9d-bc39-38fc-a479-eadbf0f3a933'
  end

  def query_string
    '?inc=artists+url-rels'
  end

  specify '#cache_key' do
    expected = "release-group/#{uuid}#{query_string}"
    expect(@foreign_id.cache_key).to eq(expected)
  end
end

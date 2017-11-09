require "rails_helper"

RSpec.describe BrainzReleaseGroupRef do
  def query_string
    '?inc=artists+url-rels'
  end

  def uuid
    '1ef054e8-8d38-49a9-9c57-1a7919577513'
  end

  before(:all) do
    @reference = BrainzReleaseGroupRef.new(code: uuid)
  end

  specify '#to_key' do
    expected = "release-group/#{uuid}#{query_string}"
    expect(@reference.to_key).to eq(expected)
  end
end

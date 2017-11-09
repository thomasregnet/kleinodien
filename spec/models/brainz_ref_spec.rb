require "rails_helper"

RSpec.describe BrainzRef do
  before(:all) do
    @reference = BrainzRef.new(code: '354f6427-e2d8-47e5-99bc-538992120eb7')
  end

  specify '#schema' do
    expect(@reference.schema).to  eq('https')
  end

  specify '#host' do
    expect(@reference.host).to eq('musicbrainz.org')
  end

  specify '#path_prefix' do
    expect(@reference.path_prefix).to eq('ws/2')
  end
end

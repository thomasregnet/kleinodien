require "rails_helper"

RSpec.describe BrainzRef do
  before(:all) do
    @foreign_id = BrainzRef.new(value: '354f6427-e2d8-47e5-99bc-538992120eb7')
  end

  specify '#schema' do
    expect(@foreign_id.schema).to  eq('https')
  end

  specify '#host' do
    expect(@foreign_id.host).to eq('musicbrainz.org')
  end

  specify '#path_prefix' do
    expect(@foreign_id.path_prefix).to eq('ws/2')
  end
end

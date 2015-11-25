require 'rails_helper'

RSpec.describe Insert::Discogs, type: :model do
  it 'responds to "release"' do
    expect(Insert::Discogs).to respond_to('release')
  end
end

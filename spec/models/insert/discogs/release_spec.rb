require 'rails_helper'

RSpec.describe Insert::Discogs::Release, type: :model do
  context 'whithout data' do
    before(:all) do
      @release = Insert::Discogs::Release.new
    end
    
    it 'responds to "run"' do
      expect(@release).to respond_to(:run)
    end
  end
end

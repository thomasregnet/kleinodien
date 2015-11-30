require 'rails_helper'

RSpec.describe Discogs::InsertRelease, type: :model do
  context 'interface' do
    before (:each) do
      @insert_release = Discogs::InsertRelease.new
    end

    it 'responds to "perform"' do
      expect(@insert_release).to respond_to(:perform)
    end

    specify 'class Discogs::InsertRelease responds to "perform"' do
      expect(Discogs::InsertRelease).to respond_to(:perform)
    end
  end
    
end

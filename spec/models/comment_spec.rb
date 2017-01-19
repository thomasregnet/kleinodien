require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @comment = FactoryGirl.create(:comment_on_artist_credit)
  end

  it 'is not valid without a text' do
    @comment.user = nil
    expect(@comment).not_to be_valid
  end

  it 'is not valid without an user' do
    @comment.user = nil
    expect(@comment).not_to be_valid
  end

  context 'only valid with exact one content' do
    before(:each) do
      @comment = FactoryGirl.create(:comment_on_artist_credit)
    end

    factories = [
      :artist, :compilation_head, :compilation_release, :piece_head,
      :piece_release, :repository, :season, :serial, :station
    ]

    factories.each do |factory|
      it 'is not valid with more than one content' do
        setter = factory.to_s + '='
        @comment.send setter, FactoryGirl.create(factory)
        expect(@comment).not_to be_valid
      end
    end
  end
end

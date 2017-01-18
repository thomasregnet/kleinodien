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
end

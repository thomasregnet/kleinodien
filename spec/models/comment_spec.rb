require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @comment = FactoryGirl.create(:comment_on_artist)
  end

  it 'is not valid without a text' do
    @comment.user = nil
    expect(@comment).not_to be_valid
  end

  it 'is not valid without an user' do
    @comment.user = nil
    expect(@comment).not_to be_valid
  end

  context 'without a content' do
    before(:each) do
      @comment = FactoryGirl.build(:comment)
    end

    it 'is not valid' do
      expect(@comment).not_to be_valid
    end

    it 'raises an error when it is saved without validations' do
      expect { @comment.save! validate: false }
        .to raise_error /exact_one_content/
    end
  end

  context 'valid with exact one content' do
    before(:each) do
      @comment = FactoryGirl.create(:comment_on_artist)
    end

    factories = %i[
      artist_credit compilation_head compilation_release piece_head
      piece_release repository season serial station
    ]

    factories.each do |factory|
      it 'is not valid with more than one content' do
        setter = factory.to_s + '='
        @comment.send setter, FactoryGirl.create(factory)
        puts factory.to_s
        expect(@comment).not_to be_valid
        expect { @comment.save! validate: false }
          .to raise_error /exact_one_content_on_comments/
      end
    end
  end
end

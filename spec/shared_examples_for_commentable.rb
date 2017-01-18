RSpec.shared_examples "a commentable model" do
  it 'responds to #comments' do
    expect(commentable).to respond_to(:comments)
  end

  it 'accepts a comment' do
    comment = FactoryGirl.create(:comment)
    commentable.comments << comment
    expect(commentable.comments.length).to eq 1
  end
end

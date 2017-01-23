RSpec.shared_examples 'a rateable model' do
  it 'responds to #ratings' do
    expect(rateable).to respond_to(:ratings)
  end

  it 'accepts a rating' do
    rateable.ratings << FactoryGirl.build(:rating)
    expect(rateable.ratings.length).to eq 1
  end
end

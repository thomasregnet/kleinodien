# frozen_string_literal: true

RSpec.shared_examples 'a rateable model' do
  it 'responds to #ratings' do
    expect(rateable).to respond_to(:ratings)
  end

  it 'accepts a rating' do
    rateable.ratings << FactoryBot.build(:rating)
    expect(rateable.ratings.length).to eq 1
  end
end

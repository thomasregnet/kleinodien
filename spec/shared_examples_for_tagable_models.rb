RSpec.shared_examples 'a tagable model' do
  describe '#tags' do
    it 'accepts a new tag' do
      tagable.tags << FactoryBot.create(:tag)
      expect(tagable.tags.length).to eq 1
      expect { tagable.save! }.not_to raise_error
    end
  end
end

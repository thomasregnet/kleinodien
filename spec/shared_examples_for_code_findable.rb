# frozen_string_literal: true

# TODO: fill in an example for each possible "_code"
def codes
  {
    brainz_code:   '736a923d-daff-4486-8fef-2e38207c49be',
    discogs_code:  321,
    imdb_code:     654,
    tmdb_code:     999,
    wikidata_code: 777
  }
end

RSpec.shared_examples 'a code findable entity' do
  it 'responds to .find_by_codes' do
    expect(described_class).to respond_to(:find_by_codes).with(1).argument
  end

  context 'when no model with that codes exists' do
    it 'returns an empty ActiveRecord::Relation' do
      expect(described_class.find_by_codes(codes)).to be_nil
    end
  end

  # This may be a dirty trick, but it works
  codes.each do |key, code|
    name = key.to_s
    next unless described_class.column_names.include?(name.to_s)

    context "when a model with #{name}: #{code} exists" do
      it 'returns an ActiveRecord::Relation containing that entity' do
        FactoryBot.create(factory, key => code)
        expect(described_class.find_by_codes(codes))
          .to be_instance_of(described_class)
      end
    end
  end
end

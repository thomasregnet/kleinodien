# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReleaseCopiesHelper. For example:
#
# describe ReleaseCopiesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ReleaseCopiesHelper, type: :helper do
  describe '#release_copy_title_for' do
    let(:release) { FactoryBot.build(:release, title: 'release') }
    let(:release_head) { FactoryBot.build(:release_head, title: 'release head') }

    context 'with release and release_head' do
      it 'returns the release title' do
        expect(helper.release_copy_title_for(release, release_head)).to eq('release')
      end
    end

    context 'with release and no release_head' do
      it 'returns the release title' do
        expect(helper.release_copy_title_for(release, nil)).to eq('release')
      end
    end

    context 'with no release and a release_head' do
      it 'returns the release title' do
        expect(helper.release_copy_title_for(nil, release_head)).to eq('release head')
      end
    end

    context 'without release and without release_head' do
      it 'returns the release title' do
        expect(helper.release_copy_title_for(nil, nil)).to be_nil
      end
    end
  end

  describe '#release_copy_artist_credit_for' do
    let(:release) { FactoryBot.build(:release, title: 'release') }
    let(:release_head) { FactoryBot.build(:release_head, title: 'release head') }

    context 'without any artist_credit' do
      it 'returns nil' do
        expect(helper.release_copy_artist_credit_for(release, release_head)).to be_nil
      end
    end

    context 'with a release containing an artist_credit' do
      let(:artist_credit) { FactoryBot.build(:artist_credit, name: 'Release artist') }

      it 'returns that artist_credit name' do
        allow(release).to receive(:artist_credit).and_return(artist_credit)
        expect(helper.release_copy_artist_credit_for(release, release_head)).to eq('by Release artist')
      end
    end

    context 'with a release_head containing an artist_credit' do
      let(:artist_credit) { FactoryBot.build(:artist_credit, name: 'ReleaseHead artist') }

      it 'returns that artist_credit name' do
        allow(release_head).to receive(:artist_credit).and_return(artist_credit)
        expect(helper.release_copy_artist_credit_for(release, release_head)).to eq('by ReleaseHead artist')
      end
    end

    context 'without a release and without a ReleaseHead' do
      it 'returns nil' do
        expect(helper.release_copy_artist_credit_for(nil, nil)).to be_nil
      end
    end
  end
end

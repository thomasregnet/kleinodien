require 'rails_helper'
require 'shared_examples_for_commentable'
require 'shared_examples_for_code_findable'
require 'shared_examples_for_models_with_companies'
require 'shared_examples_for_models_with_countries'
require 'shared_examples_for_models_with_credits'
require 'shared_examples_for_models_with_labels'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_rateable_models'
require 'shared_examples_for_sources'
require 'shared_examples_for_tagable_models'
require 'shared_examples_for_models_with_brainz_constructors'

RSpec.describe PieceHead, type: :model do
  specify '#descriptions' do
    expect(subject).to respond_to(:descriptions)
  end

  it_behaves_like 'a commentable model' do
    before(:all) do
      DatabaseCleaner.start
      @piece_head = FactoryBot.create(:piece_head)
    end

    let(:commentable) { @piece_head }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a code findable entity' do
    before { DatabaseCleaner.start }
    let(:factory) { :piece_head }
    after { DatabaseCleaner.clean }
  end

  # it_behaves_like 'a model with BrainzConstructors' do
  #   let(:klass) { AlbumHead }
  # end

  before(:each) do
    @ph = FactoryBot.build(:piece_head)
  end

  it 'is valid with valid attributes' do
    expect(@ph).to be_valid
  end

  it_behaves_like 'a rateable model' do
    before(:all) do
      DatabaseCleaner.start
      @piece_head = FactoryBot.create(:piece_head)
    end

    let(:rateable) { @piece_head }

    after(:all) { DatabaseCleaner.clean }
  end

  it_behaves_like 'a tagable model' do
    before(:all) do
      DatabaseCleaner.start
      @tagable = FactoryBot.create(:piece_head)
    end

    let(:tagable) { @tagable }

    after(:all) { DatabaseCleaner.clean }
  end

  it "is allowed to use same 'name' and 'disambiguation' if type 'differs'" do
    @s_head = FactoryBot.build(
      :song_head,
      title:          @ph.title,
      disambiguation: @ph.disambiguation,
      # source_ident:   nil
    )
    expect(@s_head).to be_valid
    expect { @s_head.save! }.not_to raise_error

    disambiguation = 'disambiguate this!'
    @s_head.disambiguation = disambiguation
    @ph.disambiguation = disambiguation
    expect(@s_head).to be_valid
    expect(@ph).to be_valid
    expect { @s_head.save! }.not_to raise_error
    expect { @ph.save! }.not_to raise_error
  end

  it 'is not valid without a type' do
    @ph.type = nil
    expect(@ph).not_to be_valid
  end

  it_behaves_like 'a model with companies' do
    let(:candidate) { FactoryBot.create(:piece_head_with_companies) }
  end

  it_behaves_like 'a model with countries' do
    let(:candidate) { FactoryBot.create(:piece_head_with_countries) }
  end

  it_behaves_like 'a model with credits' do
    let(:candidate) { FactoryBot.create(:piece_head_with_credits) }
  end

  it_behaves_like 'a model with labels' do
    let(:candidate) { FactoryBot.create(:piece_head_with_labels) }
  end

  it_behaves_like 'a model with disambiguations' do
    let(:factory) { :piece_head }
    let(:object) { @ph }
    let(:naming) { 'title' }
  end

  it_behaves_like 'an object with a source' do
    let(:candidate) { FactoryBot.create(:piece_head) }
  end
end

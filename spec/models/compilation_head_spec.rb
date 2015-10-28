require 'rails_helper'
require 'shared_examples_for_disambiguations'
require 'shared_examples_for_models_with_companies'
require 'shared_examples_for_models_with_countries'
require 'shared_examples_for_models_with_credits'
require 'shared_examples_for_models_with_a_reference'
require 'shared_examples_for_models_with_many_references'
require 'shared_examples_for_models_with_labels'

RSpec.describe CompilationHead, type: :model do
  before(:each) do
    @c_head = FactoryGirl.create(:compilation_head)
  end

  it "is valid with valid attributes" do
    expect(@c_head).to be_valid
  end

  it "is allowed to use same 'name' and 'disambiguation' if type 'differs'" do
    @a_head = FactoryGirl.build(
      :album_head,
      title:          @c_head.title,
      disambiguation: @c_head.disambiguation
    )
    expect(@a_head).to be_valid
    expect { @a_head.save! }.not_to raise_error

    disambiguation = 'disambiguate this!'
    @a_head.disambiguation = disambiguation
    @c_head.disambiguation = disambiguation
    expect(@a_head).to be_valid
    expect(@c_head).to be_valid
    expect { @a_head.save! }.not_to raise_error
    expect { @c_head.save! }.not_to raise_error
  end

  it_behaves_like "a model with companies" do
    let(:factory) { :compilation_head_with_companies }
  end

  it_behaves_like "a model with countries" do
    let(:factory) { :compilation_head_with_countries }
  end

  it_behaves_like "a model with credits" do
    let(:factory) { :compilation_head_with_credits }
  end

  it_behaves_like "a model with labels" do
    let(:factory) { :compilation_head_with_labels }
  end

  it_behaves_like 'a model with a Reference' do
    let(:factory) { :compilation_head_with_a_reference }
  end

  it_behaves_like 'a model with many References' do
    let(:factory) { :compilation_head_with_many_references }
  end  

  it_behaves_like "a model with disambiguations" do
    let(:factory) { :compilation_head }
    let(:object) { @c_head }
    let(:naming) { 'title' }
  end
end

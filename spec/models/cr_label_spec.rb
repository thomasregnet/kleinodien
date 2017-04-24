require 'rails_helper'
require 'shared_examples_for_labels'

RSpec.describe CrLabel, type: :model do
  it_behaves_like 'a label' do
    let(:owner_setter) { 'compilation_release=' }
    let(:label)        { FactoryGirl.build(:cr_label) }
    let(:label_with_catalog_no) do
      FactoryGirl.build(:cr_label_with_catalog_no)
    end
  end
end

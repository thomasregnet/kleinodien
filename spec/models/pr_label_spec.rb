require 'rails_helper'
require 'shared_examples_for_labels'

RSpec.describe PrLabel, type: :model do
  it_behaves_like 'a label' do
    let(:owner_setter) { 'piece_release=' }
    let(:label)        { FactoryGirl.build(:pr_label) }
    let(:label_with_catalog_no) do
      FactoryGirl.build(:pr_label_with_catalog_no)
    end
  end
end

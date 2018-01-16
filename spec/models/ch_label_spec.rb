require 'rails_helper'
require 'shared_examples_for_labels'

RSpec.describe ChLabel, type: :model do
  it_behaves_like 'a label' do
    let(:owner_setter) { 'compilation_head=' }
    let(:label)        { FactoryBot.build(:ch_label) }
    let(:label_with_catalog_no) do
      FactoryBot.build(:ch_label_with_catalog_no)
    end
  end
end

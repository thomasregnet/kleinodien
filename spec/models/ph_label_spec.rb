# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_labels'

RSpec.describe PhLabel, type: :model do
  it_behaves_like 'a label' do
    let(:owner_setter) { 'piece_head=' }
    let(:label)        { FactoryBot.build(:ph_label) }
    let(:label_with_catalog_no) do
      FactoryBot.build(:ph_label_with_catalog_no)
    end
  end
end

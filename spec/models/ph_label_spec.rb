require 'rails_helper'
require 'shared_examples_for_labels'

RSpec.describe PhLabel, type: :model do
  it_behaves_like 'a label' do
    let(:factory)                 { :ph_label }
    let(:with_catalog_no_factory) { :ph_label_with_catalog_no }
    let(:owner_setter)            { 'piece_head=' }
  end
end

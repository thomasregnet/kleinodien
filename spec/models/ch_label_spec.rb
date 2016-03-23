require 'rails_helper'
require 'shared_examples_for_labels'

RSpec.describe ChLabel, type: :model do
  it_behaves_like 'a label' do
    let(:factory)                 { :ch_label }
    let(:with_catalog_no_factory) { :ch_label_with_catalog_no }
    let(:owner_setter)            { 'compilation_head=' }
  end
end

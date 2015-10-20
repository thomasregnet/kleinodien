require 'rails_helper'
require 'shared_examples_for_labels'

RSpec.describe PrLabel, type: :model do
  it_behaves_like "a label" do
    let(:factory)                 { :pr_label }
    let(:with_catalog_no_factory) { :pr_label_with_catalog_no }
    let(:owner_setter)            { 'piece_release=' }
  end
end

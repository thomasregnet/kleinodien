require 'rails_helper'
require 'shared_examples_for_format_kinds'

RSpec.describe TrfAttributeKind, type: :model do
  it_behaves_like "a format kind" do
    let(:factory) { :trf_attribute_kind }
  end
end

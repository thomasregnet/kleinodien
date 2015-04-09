require 'rails_helper'
require 'shared_examples_for_format_kinds'

RSpec.describe CrfAttributeKind, type: :model do
  it_behaves_like "a format kind" do
    let(:factory) { :crf_attribute_kind }
  end
end

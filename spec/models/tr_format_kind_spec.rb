require 'rails_helper'
require 'shared_examples_for_format_kinds'

RSpec.describe TrFormatKind, type: :model do
  it_behaves_like "a format kind" do
    let(:factory) { :tr_format_kind }
  end
end

require 'rails_helper'
require 'shared_examples_for_format_kinds'

RSpec.describe CrfDetailKind, type: :model do
  it_behaves_like "a format kind" do
    let(:factory) { :crf_detail_kind }
  end
end

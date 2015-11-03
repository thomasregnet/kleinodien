require 'rails_helper'
require 'shared_examples_for_format_kinds'

RSpec.describe TrackDetailKind do
  it_behaves_like "a format kind" do
    let(:factory) { :track_detail_kind }
  end
end

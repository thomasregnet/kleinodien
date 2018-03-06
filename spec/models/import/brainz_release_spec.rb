require 'rails_helper'

RSpec.describe Import::BrainzRelease, type: :model do
  it { is_expected.to respond_to(:code) }
end

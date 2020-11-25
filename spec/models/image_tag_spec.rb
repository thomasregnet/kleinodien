# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImageTag, type: :model do
  subject { FactoryBot.create(:image_tag) }

  it { should have_and_belong_to_many(:release_images) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
end

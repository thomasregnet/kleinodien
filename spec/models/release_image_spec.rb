# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_images'

RSpec.describe ReleaseImage, type: :model do
  subject { FactoryBot.build(:release_image) }

  it_behaves_like 'an image'

  it { should belong_to(:release) }
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReleaseCatalogNumber, type: :model do
  it { should validate_presence_of(:code) }

  it { should belong_to(:release_company) }
end

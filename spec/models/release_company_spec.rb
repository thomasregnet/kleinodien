# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReleaseCompany, type: :model do
  subject { FactoryBot.build(:release_company) }

  it { should belong_to(:company) }
  it { should belong_to(:release) }
  it { should belong_to(:role).optional }
  it { should have_many(:catalog_numbers) }
end

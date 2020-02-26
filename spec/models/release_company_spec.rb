# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReleaseCompany, type: :model do
  subject { FactoryBot.build(:release_company) }

  it { should belong_to(:company) }
  it { should belong_to(:release) }
  it { should belong_to(:role).optional }
  it { should have_many(:catalog_numbers) }

  # rubocop:disable RSpec/ImplicitSubject
  it do
    should validate_uniqueness_of(:company_id)
      .scoped_to(%i[release_id company_role_id])
  end
  # rubocop:disable RSpec/ImplicitSubject
end

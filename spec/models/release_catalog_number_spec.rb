# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReleaseCatalogNumber, type: :model do
  it { should belong_to(:release_company) }
  it { should have_db_index(%i[code release_company_id]).unique }
  it { should validate_presence_of(:code) }

  it 'validates the uniqueness of code in scope of the ReleaseCompany' do
    catalog_no = FactoryBot.build(:release_catalog_number)
    expect(catalog_no).to validate_uniqueness_of(:code)
      .scoped_to(:release_company_id)
      .case_insensitive
  end
end

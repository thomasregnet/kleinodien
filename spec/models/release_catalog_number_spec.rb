# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReleaseCatalogNumber, type: :model do
  it { should validate_presence_of(:code) }

  describe 'uniqueness of code in scope with ReleaseCompany' do
    subject do
      described_class.create!(
        code:            'aaa',
        release_company: FactoryBot.create(:release_company)
      )
    end

    # rubocop:disable RSpec/ImplicitSubject
    it do
     should validate_uniqueness_of(:code)
       .scoped_to(:release_company_id)
       .case_insensitive
   end
   # rubocop:disable RSpec/ImplicitSubject
  end

  it { should belong_to(:release_company) }
  it { should have_db_index([:code, :release_company_id]).unique }
end

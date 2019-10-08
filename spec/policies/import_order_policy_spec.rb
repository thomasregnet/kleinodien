require 'rails_helper'

RSpec.describe ImportOrderPolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :show? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  permissions :create? do
    # pending "add some examples to (or delete) #{__FILE__}"
    it 'denies access unless user is an importer' do
      expect(subject)
        .not_to permit(
          FactoryBot.create(:user),
          FactoryBot.build(:import_order)
        )
    end

    it 'grants access if user is importer' do
      expect(subject)
        .to permit(
          FactoryBot.create(:importer),
          FactoryBot.build(:import_order)
        )
    end
  end

  # permissions :update? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  # permissions :destroy? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
end

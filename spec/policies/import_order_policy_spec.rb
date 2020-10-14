# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportOrderPolicy, type: :policy do
  subject { described_class }

  let(:import_order) { FactoryBot.build(:import_order) }
  let(:user) { User.new }

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

  permissions :show? do
    it 'denies access unless the user is authenticated' do
      expect(described_class).not_to permit(nil, import_order)
    end

    it 'denies access unless the user has permissions to import' do
      expect(described_class).not_to permit(user, import_order)
    end

    it 'grants access if the user has permissions to import' do
      user.importer = true
      expect(described_class).to permit(user, import_order)
    end
  end
end

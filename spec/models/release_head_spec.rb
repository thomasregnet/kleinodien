# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReleaseHead, type: :model do
  it { should respond_to(:front_cover) }

  it { should belong_to(:artist_credit).without_validating_presence }
  it { should belong_to(:import_order).without_validating_presence }
  it { should have_many(:releases) }

  describe '#title' do
    let(:head) { FactoryBot.build(:release_head) }

    context 'when nil' do
      it 'is not valid' do
        head.title = nil
        expect(head).not_to be_valid
      end
    end

    context 'when blank' do
      it 'is not valid' do
        head.title = ''
        expect(head).not_to be_valid
      end
    end
  end
end

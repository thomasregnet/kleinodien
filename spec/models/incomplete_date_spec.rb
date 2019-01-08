# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IncompleteDate, type: :model do
  describe '.new' do
    let(:incomplete_date) do
      KleinodienDateTime::IncompleteDate.new(Date.new(2015, 12, 13), 7)
    end

    specify '#date' do
      expect(incomplete_date.date).to be_instance_of Date
    end

    specify '#mask' do
      expect(incomplete_date.mask).to eq 7
    end
  end

  describe '.from_string' do
    context 'with a complete date' do
      let(:incomplete_date) do
        KleinodienDateTime::IncompleteDate.from_string('2015-12-13')
      end

      specify '#mask' do
        expect(incomplete_date.mask).to eq 7
      end

      specify '#to_s' do
        expect(incomplete_date.to_s).to eq '2015-12-13'
      end
    end

    context 'with year and month (2015-12)' do
      let(:incomplete_date) do
        KleinodienDateTime::IncompleteDate.from_string('2015-12')
      end

      specify '#mask' do
        expect(incomplete_date.mask).to eq 6
      end

      specify '#to_s' do
        expect(incomplete_date.to_s).to eq '2015-12-01'
      end
    end

    context 'with year only (2015-12)' do
      let(:incomplete_date) do
        KleinodienDateTime::IncompleteDate.from_string('2015')
      end

      specify '#mask' do
        expect(incomplete_date.mask).to eq 4
      end

      specify '#to_s' do
        expect(incomplete_date.to_s).to eq '2015-01-01'
      end
    end
  end
end

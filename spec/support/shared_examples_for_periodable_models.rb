# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a periodable model' do
  it { should respond_to(:begin_date_year) }
  it { should respond_to(:begin_date_month) }
  it { should respond_to(:begin_date_day) }
  it { should respond_to(:end_date_year) }
  it { should respond_to(:end_date_month) }
  it { should respond_to(:end_date_day) }

  context 'with an invalid begin_date' do
    it 'is not valid' do
      subject.begin_date_year = nil
      subject.begin_date_day = 1
      expect(subject).not_to be_valid
    end
  end

  context 'with an invalid end_date' do
    it 'is not valid' do
      subject.end_date_year = 2021
      subject.end_date_month = nil
      subject.end_date_day = 1
      expect(subject).not_to be_valid
    end
  end

  context 'with a begin_date newer than the end_date' do
    it 'is not valid' do
      subject.begin_date_year = 2021
      subject.end_date_year = 1860
      subject.end_date_month = 5
      subject.end_date_day = 17
      expect(subject).not_to be_valid
    end
  end
end

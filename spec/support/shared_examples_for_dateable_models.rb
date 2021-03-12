#frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a dateable model' do
  it { should respond_to(:date_year) }
  it { should respond_to(:date_month) }
  it { should respond_to(:date_day) }

  context 'with a valid date' do
    it 'is valid' do
      subject.date_year = 1860
      subject.date_month = 5
      subject.date_day = 17

      expect(subject).to be_valid
    end
  end

  context 'with a invalid date' do
    it 'is not valid' do
      subject.date_day = 33

      expect(subject).not_to be_valid
    end
  end
end
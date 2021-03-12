#frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a dateable model' do
  it { should respond_to(:date_year) }
  it { should respond_to(:date_month) }
  it { should respond_to(:date_day) }

  context 'with a valid date'

  context 'with a invalid date'
end
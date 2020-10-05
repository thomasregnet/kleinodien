# frozen_string_literal: true

RSpec.shared_examples 'a model with disambiguations' do
  let(:get_name) { naming }
  # let(:set_name) { naming + '=' }
  let(:set_name) { "#{naming}=" }
  let(:clone) { FactoryBot.build(factory) }
  let(:disambiguation) { 'another one' }

  it 'is not valid without a naming' do
    object.send set_name, nil
    expect(object).not_to be_valid
  end

  it 'can not be saved without a naming' do
    object.send set_name, nil
    expect { object.save! validate: false }.to raise_error(ActiveRecord::StatementInvalid)
  end
end

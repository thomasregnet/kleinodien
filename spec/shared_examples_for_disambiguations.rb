
RSpec.shared_examples "a model with disambiguations" do
  let(:get_name) { naming }
  let(:set_name) { naming + '=' }
  let(:clone) { FactoryGirl.build(factory) }
  let(:disambiguation) { 'another one' }

  it "is not valid without a naming" do
    object.send set_name, nil
    expect(object).not_to be_valid
    expect { object.save! validate: false }.to raise_error do |error|
      expect(error).to be_a(ActiveRecord::StatementInvalid)
    end
  end
end

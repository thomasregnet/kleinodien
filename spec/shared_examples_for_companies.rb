RSpec.shared_examples "a company" do
  it "is valid with valid attributes" do
    expect(company).to be_valid
  end

  it "is not valid without a company"  do
    company.company = nil
    expect(company).not_to be_valid
    expect { company.save! validate: false }
      .to raise_error(/null value.+_id.+not-null constraint/)
  end

  it "is not valid without a company_role" do
    company.company_role = nil
    expect(company).not_to be_valid
    expect { company.save! validate: false }
      .to raise_error(/null value.+_id.+not-null constraint/)
  end

  it "is not valid without an owner" do
    company.send(owner_setter, nil)
    expect(company).not_to be_valid
    expect { company.save! validate: false }
      .to raise_error(/null value.+id.+not-null/)
  end
end

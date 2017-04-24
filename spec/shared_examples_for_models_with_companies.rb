RSpec.shared_examples "a model with companies" do
  it "has the companies set" do
    expect(candidate.companies.length).to eq(2)
  end
end

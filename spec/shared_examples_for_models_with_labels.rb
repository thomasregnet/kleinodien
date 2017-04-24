RSpec.shared_examples "a model with labels" do
  it "has labels set" do
    expect(candidate.labels.length).to eq(2)
  end
end

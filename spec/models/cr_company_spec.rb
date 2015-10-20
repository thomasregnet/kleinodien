require 'rails_helper'
require 'shared_examples_for_companies'

RSpec.describe CrCompany, type: :model do
  it_behaves_like "a company" do
    let(:factory) { :cr_company }
  end
end

require 'rails_helper'
require 'shared_examples_for_credits'

RSpec.describe PrCredit, type: :model do

  it_behaves_like "an entity with credits" do
    let(:factory)           { :pr_credit }
    let(:factory_with_job)  { :pr_credit_with_job }
    let(:factory_with_role) { :pr_credit_with_role }
  end

end

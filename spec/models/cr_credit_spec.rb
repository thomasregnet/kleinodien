require 'rails_helper'
require 'shared_examples_for_credits'

RSpec.describe CrCredit, type: :model do

  it_behaves_like "a credit" do
    let(:factory)           { :cr_credit }
    let(:factory_with_job)  { :cr_credit_with_job }
    let(:factory_with_role) { :cr_credit_with_role }
    let(:owner_setter)      { 'compilation_release=' }
  end

end

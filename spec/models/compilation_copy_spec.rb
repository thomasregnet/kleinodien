require 'rails_helper'

RSpec.describe CompilationCopy, type: :model do
  before(:each) do
    @copy = FactoryGirl.create(:compilation_copy)
  end

  it 'is valid with valid attributes' do
    expect(@copy).to be_valid
  end

  it 'is not valid without a release' do
    @copy.release = nil
    expect(@copy).not_to be_valid
  end

  it 'raises without a release' do
    @copy.release = nil
    expect { @copy.save! validate: false }
      .to raise_error /PG::NotNullViolation: ERROR/
  end

  it 'is not valid without an user' do
    @copy.user = nil
    expect(@copy).not_to be_valid
  end

  it 'raises without a user' do
    @copy.user = nil
    expect { @copy.save! validate: false }
      .to raise_error /PG::NotNullViolation: ERROR/
  end  
end

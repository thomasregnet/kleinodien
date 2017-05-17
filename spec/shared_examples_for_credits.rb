RSpec.shared_examples 'a credit' do
  it 'is valid with the mininum of attributes' do
    expect(credit).to be_valid
  end

  it 'is valid with a role' do
    expect(credit_with_role).to be_valid
  end

  it 'is valid with a job' do
    expect(credit_with_job).to be_valid
  end

  it 'is not valid without an owner' do
    credit.send(owner_setter, nil)
    expect(credit).not_to be_valid
    expect { credit.save! validate: false }
      .to raise_error(/ERROR:\s+null value in column.+_id/)
  end

  it 'is not valid' do
    credit.artist_credit = nil
    expect(credit).not_to be_valid
    expect { credit.save! validate: false }
      .to raise_error(/ERROR:\s+null value in column "artist_credit_id"/)
  end
end

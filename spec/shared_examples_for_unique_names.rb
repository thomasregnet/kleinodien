RSpec.shared_examples 'an entity with an unique name' do
  it 'is valid with valid attributes' do
    expect(candidate).to be_valid
  end

  it 'is not valid without a name' do
    candidate.name = nil
    expect(candidate).not_to be_valid
    expect { candidate.save! validate: false }
      .to raise_error(/null value in column "name" violates not-null/)
  end

  it 'is not valid with a blank name' do
    candidate.name = ''
    expect(candidate).not_to be_valid
  end

  it 'is not valid whith the a duplicate name' do
    clone = candidate.dup
    clone.name = candidate.name

    uc_clone = candidate.dup
    uc_clone.name = candidate.name.upcase

    candidate.save

    expect(clone).not_to be_valid
    expect(uc_clone).not_to be_valid

    expect { clone.save! validate: false }
      .to raise_error(
        /duplicate key value violates unique constraint/
      )

    expect { uc_clone.save! validate: false }
      .to raise_error(
        /duplicate key value violates unique constraint/
      )
  end
end

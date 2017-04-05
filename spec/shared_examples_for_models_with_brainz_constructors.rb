RSpec.shared_examples 'a model with BrainzConstructors' do
  specify '#brainz_parameters' do
    expect(klass).to respond_to(:brainz_paramters)
  end

  specify '#brainz' do
    expect(klass).to respond_to(:brainz)
  end

  specify '#brainz_create' do
    expect(klass).to respond_to(:brainz_create)
  end

  specify '#brainz_create!' do
    expect(klass).to respond_to(:brainz_create!)
  end
end

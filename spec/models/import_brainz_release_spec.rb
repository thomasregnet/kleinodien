require 'rails_helper'

RSpec.describe ImportBrainzRelease, type: :model do
  specify '#perform' do
    expect(subject.class).to respond_to(:perform)
  end

  it 'returns a response object' do
    expect(ImportBrainzRelease.perform({}, ActionDispatch::Response.new))
      .to be_instance_of(ActionDispatch::Response)
  end

  it 'returns required data' do
    response = ImportBrainzRelease.perform(
      Hash[
        data: {
          type: 'music-brainz-release',
          attributes: {
            wanted: '404e67be-0b5e-47bc-81db-1e8c408e9e3f'
          }
        }
      ],
      ActionDispatch::Response.new
    )

    expect(response.body).to match(/foobar/)
  end
end

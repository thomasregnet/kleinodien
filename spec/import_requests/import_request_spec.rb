require 'rails_helper'

# RSpec.describe ImportRequest do
#   it { is_expected.to respond_to(:code) }
#   it { is_expected.to respond_to(:type) }

#   describe '#requested' do
#     context 'when not given' do
#       it 'returns the current time' do
#         # Using .to_s to prevent errors caused by a difference of milliseconds
#         expect(described_class.new.requested.to_s).to eq(Time.now.to_s)
#       end
#     end

#     context 'when given' do
#       before do
#         @time = Time.now
#         @import_request = ImportRequest.new(requested: @time)
#       end
#       it 'returns the given time' do
#         expect(@import_request.requested).to eq(@time)
#       end
#     end
#   end

#   context 'with type "brainz_release"' do
#     let(:import_request) do
#       described_class.new(code: 'abc', type: 'brainz_release')
#     end

#     describe '#importer_class' do
#       it 'returns "ImportBrainzReleaseService"' do
#         expect(import_request.importer_class)
#           .to eq('ImportBrainzReleaseService')
#       end
#     end

#     describe '#reference_class' do
#       it 'returns "BrainzReleaseReference"' do
#         expect(import_request.reference_class).to eq('BrainzReleaseReference')
#       end
#     end
#   end
# end

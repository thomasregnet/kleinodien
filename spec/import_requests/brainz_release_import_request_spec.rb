require 'rails_helper'
require 'shared_examples_for_import_requests'

RSpec.describe BrainzReleaseImportRequest, type: :model do
  it_behaves_like 'an import request'
end

# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_requests'

RSpec.describe BrainzReleaseImportRequest, type: :model do
  include_examples 'for ImportRequests', :brainz_release_import_request
end

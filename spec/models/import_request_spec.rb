# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_import_requests'

RSpec.describe ImportRequest, type: :model do
  # TODO: add some specs for the base-class
  # For now no specs here. The "type"-column is "NOT NULL" so
  # all specs fail because in rails the "type" of the base-class is nil.
  # https://stackoverflow.com/questions/4858122/rails-sti-and-the-setting-of-the-type-string
  # include_examples 'for ImportRequests', :import_request
end

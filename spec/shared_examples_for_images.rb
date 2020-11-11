# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'an image' do
  it { should respond_to(:archive_org_code) }
  it { should respond_to(:back) }
  it { should respond_to(:file) }
  it { should respond_to(:front) }
  it { should respond_to(:note) }
end

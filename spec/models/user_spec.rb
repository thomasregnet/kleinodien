# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should respond_to('importer?') }
  it { should respond_to(:importer) }
end

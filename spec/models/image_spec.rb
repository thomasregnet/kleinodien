# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples_for_file_attachable'

RSpec.describe Image, type: :model do
  it { should respond_to(:coverartarchive_code) }

  it_behaves_like 'a file attachable'
end

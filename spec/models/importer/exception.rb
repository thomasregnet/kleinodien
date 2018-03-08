require 'rails_helper'

RSpec.describe Importer::Exception do
  specify '.status returns 500' do
    exception = Importer::Exception.new
    expect(exception.status).to be 500
  end

  specify '.render' do
    expect(subject).to respond_to(:render)
  end
end

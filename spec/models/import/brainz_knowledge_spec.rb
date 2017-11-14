require 'rails_helper'
require 'shared_examples_for_knowledge_field'

RSpec.describe Import::BrainzKnowledge do
  it_behaves_like 'a knowledge field'
end

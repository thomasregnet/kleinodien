require 'rails_helper'
require 'shared_examples_for_knowledge_field'

# Fake Knowledge for testing
class FakeKnowledge < Import::KnowledgeField
  def initialize(reference, knowledge)
    super()
    known[reference.to_key] = knowledge
  end
end

RSpec.describe Import::KnowledgeField do
  it_behaves_like 'a knowledge field'
end

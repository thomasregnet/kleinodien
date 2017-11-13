require 'rails_helper'
require 'shared_examples_for_knowledge_about'

# Fake Knowledge for testing
class FakeKnowledge < Import::KnowledgeAbout
  def initialize(reference, knowledge)
    super()
    known[reference.to_key] = knowledge
  end
end

RSpec.describe Import::KnowledgeAbout do
  it_behaves_like 'knowledge about'
end

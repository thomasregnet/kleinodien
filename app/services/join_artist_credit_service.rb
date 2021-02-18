# frozen_string_literal: true

# Join names with join-phrases
class JoinArtistCreditService < ServiceBase
  # def initialize(**args)
  def initialize(candidates:, name_method: :name, join_phrase_method: :join_phrase)
    super()
    @candidates         = candidates
    @name_method        = name_method
    @join_phrase_method = join_phrase_method
  end

  attr_reader :candidates, :join_phrase_method, :name_method

  def call
    tokens = candidates.map { |candidate| candidate_tokens_for(candidate) }
    tokens = tokens.flatten
    tokens.pop if superfluous_join_phrase?
    tokens.join(' ')
  end

  def candidate_tokens_for(candidate)
    tokens = []
    tokens << candidate.send(name_method)
    tokens << candidate.send(join_phrase_method) if join_pharse?(candidate)
    tokens
  end

  def join_pharse?(candidate)
    return true if candidate.send(join_phrase_method)

    false
  end

  def superfluous_join_phrase?
    return false unless candidates.last.send(join_phrase_method)

    true
  end
end

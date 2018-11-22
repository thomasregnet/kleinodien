# frozen_string_literal: true

# Join names with join-phrases
class JoinArtistCreditService
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @candidates         = args[:candidates]
    @name_method        = args[:name_method]        || :name
    @join_phrase_method = args[:join_phrase_method] || :join_phrase
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

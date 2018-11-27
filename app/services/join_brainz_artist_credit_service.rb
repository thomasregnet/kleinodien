# frozen_string_literal: true

# Takes MusicBrainz blueprint returns the joined artist-credit name
class JoinBrainzArtistCreditService < JoinArtistCreditService

  # Used as parameter for JoinArtistCreditService
  class BrainzArtistNameCredit
    def initialize(args)
      @name_credit = args[:name_credit]
    end

    attr_reader :name_credit

    def name
      name_credit.artist.name
    end

    def join_phrase
      joinphrase = name_credit.joinphrase
      return unless joinphrase

      joinphrase.strip
    end
  end

  def initialize(args)
    @name_credits = args[:name_credits]
  end

  attr_reader :name_credits

  def call
    JoinArtistCreditService.call(candidates: candidates)
  end

  def candidates
    # name_credits.artist_credit.name_credits.map do |name_credit|
    name_credits.map do |name_credit|
      BrainzArtistNameCredit.new(name_credit: name_credit)
    end
  end
end

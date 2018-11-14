# frozen_string_literal: true

# Prepare a MusicBrainz Artist for import
class PrepareBrainzArtistCredit
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :proxy

  def call
    return if already_have

    blueprint.name_credits.each do |name_credit| 
      prepare_brainz_artist(name_credit)
    end
  end

  def already_have
    # TODO: implement already_have
  end

  def prepare_brainz_artist(name_credit)
    PrepareBrainzArtist.call(
      blueprint: name_credit,
      proxy:     proxy
    )
  end
end

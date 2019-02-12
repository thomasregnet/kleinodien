# frozen_string_literal: true

# Persist a MusicBrainz Track
class PersistBrainzHeapTrack
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint    = args[:blueprint]
    @import_order = args[:import_order]
    @no           = args[:no]
    @proxy        = args[:proxy]
    @subset       = args[:subset]
  end

  attr_reader :blueprint, :no, :proxy, :subset

  def call
    true
  end
end

# frozen_string_literal: true

# Persist a MusicBrainz medium
class PersistBrainzHeapSubset
  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @blueprint = args[:blueprint]
    @heap      = args[:heap]
    @proxy     = args[:proxy]
  end

  attr_reader :blueprint, :heap, :proxy

  def call
    heap.subsets.create!(no: blueprint.position, title: title)
  end

  def title
    title = blueprint.title
    return title if title

    "#{blueprint.format.__content__} #{blueprint.position}"
  end
end

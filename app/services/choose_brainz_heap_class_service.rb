# frozen_string_literal: true

# Return the kleinodien class name for a MusicBrainz release
class ChooseBrainzHeapClassService
  CLASS_NAME_FOR = {
    'Album' => 'Album',
    'Single' => 'Single'
  }.freeze

  DEFAULT_CLASS_NAME = 'Heap'

  def self.call(args)
    new(args).call
  end

  def initialize(args)
    @type = args[:type]
  end

  attr_reader :type

  def call
    class_name = CLASS_NAME_FOR[type]
    class_name ? class_name : DEFAULT_CLASS_NAME
  end
end

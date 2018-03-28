# frozen_string_literal: true

# An import request to be queued on for import
class ImportRequest
  include ActiveModel::Model

  IMPORTER_CLASS_FOR = {
    brainz_release: 'ImportBrainzReleaseService'
  }.freeze

  REFERENCE_CLASS_FOR = {
    brainz_release: 'BrainzReleaseReference'
  }.freeze

  # This method smells of :reek:Attribute
  attr_accessor :code, :type
  # This method smells of :reek:Attribute
  attr_writer :requested

  validates :code, presence: true
  validates :type, presence: true

  def importer_class
    return unless type
    IMPORTER_CLASS_FOR[type.to_sym]
  end

  def reference_class
    return unless type
    REFERENCE_CLASS_FOR[type.to_sym]
  end

  def requested
    @requested ||= Time.now
  end
end

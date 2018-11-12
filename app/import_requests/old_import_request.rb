# frozen_string_literal: true

# An import request to be queued on for import
class OldImportRequest
  include ActiveModel::Model
  include ActiveRecord::Callbacks

  IMPORTER_CLASS_FOR = {
    brainz_release: 'ImportBrainzReleaseService'
  }.freeze

  REFERENCE_CLASS_FOR = {
    brainz_release: 'BrainzReleaseReference'
  }.freeze

  # This method smells of :reek:Attribute
  attr_accessor :code, :requested, :type

  def initialize(args = {})
    super(args)
    @requested = Time.now unless requested
  end

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
end

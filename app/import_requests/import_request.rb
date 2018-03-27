# frozen_string_literal: true

# An import request to be queued on for import
class ImportRequest
  include ActiveModel::Model

  # This method smells of :reek:Attribute
  attr_accessor :code, :importer_class, :reference_class, :requested

  def self.brainz_release(args)
    new(
      args.merge(
        importer_class:  'ImportBrainzReleaseService',
        reference_class: 'BrainzReleaseReference'
      )
    )
  end

  validates :code, presence: true
  validates :importer_class, presence: true
  validates :reference_class, presence: true
end

class BrainzReleaseImportRequest
  include ActiveModel::Model
  include ImportRequest

  importer_class 'ImportBrainzReleaseService'
  reference_class ::BrainzReleaseReference
end

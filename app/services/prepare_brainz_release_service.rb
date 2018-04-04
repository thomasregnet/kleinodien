class PrepareBrainzReleaseService
  include CallWithArgs

  private

  attr_reader :importer_name, :reference

  def initialize(args)
    @importer_name = args[:importer_name]
    @reference     = args[:reference]
  end

  def private_call
    # TODO: Check if that release does not already exists in the database
    # TODO: is the release already cached?
    # TODO: if the release is already cached get the ArtistCredit
  end
end

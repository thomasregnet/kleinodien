# Mixin class methods #brainz, #brainz_create and #brainz_create
module BrainzConstructors
  def self.included(base)
    base.extend ClassMethods
  end

  # Class methods to be mixed in
  module ClassMethods
    def brainz(brainz_artist)
      new(brainz_parameters(brainz_artist))
    end

    def brainz_create(brainz_artist)
      create(brainz_parameters(brainz_artist))
    end

    def brainz_create!(brainz_artist)
      create!(brainz_parameters(brainz_artist))
    end
  end
end

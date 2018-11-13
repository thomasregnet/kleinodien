# frozen_string_literal: true

# ImportOrder for MusicBrainz
class BrainzImportOrder < ImportOrder
  include CodeUuidValidation
  # validates :code,
  #           format: {
  #             with: %r{
  #               \A
  #               [a-z0-9]{8}
  #               -
  #               [a-z0-9]{4}
  #               -
  #               [a-z0-9]{4}
  #               -
  #               [a-z0-9]{4}
  #               -
  #               [a-z0-9]{12}
  #               \z
  #               }x,
  #             message: 'must be an uuid'
  #           }
end

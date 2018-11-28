# frozen_string_literal: true

# Import a Release from MusicBrainz
class ImportBrainzRelease
  def self.call(import_order)
    new(import_order).call
  end

  def initialize(import_order)
    @import_order = import_order
  end

  attr_reader :import_order

  def call
    # By creating the import_request the import_order values is validated.
    # So we create the import_request at the very first time.
    import_request

    result = find_already_existing || prepare
    return { result: result, new_record: false } if result

    result = persist
    { result: result, new_record: true }
  end

  def find_already_existing
    CompilationRelease.find_by(brainz_code: import_request.code)
  end

  def import_request
    @import_request ||= TransformBrainzOrderToRequestService.call(
      expected_kind: :release,
      import_order:  import_order
    )
  end

  def prepare
    PrepareBrainzRelease.call(
      blueprint: blueprint,
      proxy:     proxy
    )
  end

  def blueprint
    proxy.get(import_request)
  end

  def proxy
    @proxy ||= BrainzProxy.new(import_order: import_order)
  end

  def persist
    proxy.lock

    import_order.transaction do
      PersistBrainzCompilationRelease.call(
        blueprint: blueprint,
        proxy:     proxy
      )
    end
  end
end

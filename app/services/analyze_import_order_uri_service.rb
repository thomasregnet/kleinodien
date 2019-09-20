# frozen_string_literal: true

# Derive code and type from an uri
class AnalyzeImportOrderUriService < ServiceBase
  ANALYSIS_CLASS_FOR  = {
    'musicbrainz.org' => 'AnalyzeBrainzImportOrderUriService'
  }.freeze

  def initialize(uri_string:)
    @uri_string = uri_string
  end

  attr_reader :uri_string

  def call
    specific_class = host_specific_analysis_class || return

    specific_class.call(uri_obj: uri_obj)
  end

  private

  def host_specific_analysis_class
    host = uri_obj.host || return
    return unless (specific_class = ANALYSIS_CLASS_FOR[host])

    specific_class.constantize
  end

  def uri_obj
    @uri_obj ||= URI(uri_string)
  end
end

module Api
  module V01
    # Import releases from MusicBrainz
    class BrainzReleasesController < ApplicationController
      # TODO: Verify if "skip_before_action :verify_authenticity_token""
      # TODO: is a security issue.
      # The "skip_before_action" was introduced to let development
      # with the import-api continue, maybe it is a bad idea.
      skip_before_action :verify_authenticity_token

      private

      attr_reader :import

      public

      def create
        @import = ::Importer::BrainzCompilationRelease.perform(
          params: brainz_params
        )
      rescue ::Importer::Exception => exception
        handle_import_exception(exception)
      else
        response_to_client
      end

      private

      def handle_import_exception(exception)
        response.status = exception.status
        exception.render
      end

      def response_to_client
        response.content_type = 'application/vnd.api+json'
        response.status = import[:data][:attributes][:http_status_code]
        render json: import.to_json
      end

      def brainz_params
        params.permit(data: {})
      end
    end
  end
end

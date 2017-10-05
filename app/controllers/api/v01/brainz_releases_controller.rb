module Api
  module V01
    # Import releases from MusicBrainz
    class BrainzReleasesController < ApplicationController
      private

      attr_reader :import

      public

      def create
        @import = ImportBrainzRelease.perform(brainz_params)
      rescue ImportException => exception
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

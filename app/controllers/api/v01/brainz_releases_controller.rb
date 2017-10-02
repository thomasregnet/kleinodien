module Api
  module V01
    # Import releases from MusicBrainz
    class BrainzReleasesController < ApplicationController
      def create
        cache = ImportCache.new
        begin
          ImportBrainzRelease.perform(brainz_params, cache)
        rescue ImportException => exception
          handle_import_exception(exception)
        else
          response_to_client
        end
      end

      private

      def handle_import_exception(exception)
        response.status = exception.status
        exception.render
      end

      def response_to_client
        response.content_type = 'application/vnd.api+json'
        response.status = 202
        render json: { foo: 'bar' }
      end

      def brainz_params
        params.permit(data: {})
      end
    end
  end
end

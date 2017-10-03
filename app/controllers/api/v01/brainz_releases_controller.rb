module Api
  module V01
    # Import releases from MusicBrainz
    class BrainzReleasesController < ApplicationController
      private

      attr_reader :cache, :import

      public

      before_action :initialize_cache

      def create
        @import = ImportBrainzRelease.perform(brainz_params, cache)
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

      def initialize_cache
        @cache = ImportCache.new
      end

      def response_to_client
        response.content_type = 'application/vnd.api+json'
        response.status = 202
        render json: cache.render
      end

      def brainz_params
        params.permit(data: {})
      end
    end
  end
end

require 'import/brainz_release'

module Api
  module Import
    # Controller for MusicBrainz-Release imports
    class BrainzReleasesController < ApplicationController
      def create
        ::Import::BrainzRelease.perform(params[:data])
      end
    end
  end
end

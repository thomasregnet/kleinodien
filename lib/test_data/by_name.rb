# frozen_string_literal: true

require 'test_data/brainz_service'

module TestData
  # Get test-data by name
  class ByName
    CLASS_AND_ARGUMENTS_FOR = {
      brainz_area_germany:                     {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '85752fda-13c4-31a3-bee5-0e5cb1f51dad',
          kind: :area
        }
      },
      brainz_artist_ac_dc:                     {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '66c662b6-6e2f-4930-8610-912e24c63ed1',
          kind: :artist
        }
      },
      brainz_artist_jello_biafra:              {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '2280ca0e-6968-4349-8c36-cb0cbd6ee95f',
          kind: :artist
        }
      },
      brainz_artist_nomeansno:                 {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '37e9d7b2-7779-41b2-b2eb-3685351caad3',
          kind: :artist
        }
      },
      brainz_artist_sepultura:                 {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '1d93c839-22e7-4f76-ad84-d27039efc048',
          kind: :artist
        }
      },
      brainz_artist_slayer:                    {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: 'bdacc37b-8633-4bf8-9dd5-4662ee651aec',
          kind: :artist
        }
      },
      brainz_label_alternative_tentacles:      {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: 'f1273178-651b-4d02-8f21-4ab1ec5a689a',
          kind: :label
        }
      },
      brainz_label_noise:                      {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: 'f83683d7-15d7-4f87-9b1d-d3870d64ec16',
          kind: :label
        }
      },
      brainz_recording_arise:                  {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '31b0bbce-1d50-4e2f-a38f-4c49405e62d6',
          kind: :recording
        }
      },
      brainz_recording_highway_to_hell:        {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '5935ec91-8124-42ff-937f-f31a20ffe58f',
          kind: :recording
        }
      },
      brainz_recording_the_duellists:          {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '863de526-6857-4255-9e7e-7dfff4fd707e',
          kind: :recording
        }
      },
      brainz_release_arise_jp_cd:              {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a',
          kind: :release
        }
      },
      brainz_release_eaten_back_to_life:       {
        class_name: 'TestData::BrainzService',
        arguments:  { code: 'ebcfbbf1-0625-4a29-8c06-320755277e6d', kind: :release }
      },
      brainz_release_powerslave_enhanced_cd:   {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '58e6a3d6-bbbd-4864-983b-e468a5a1a71c',
          kind: :release
        }
      },
      brainz_release_the_sky_is_falling_gb_cd: {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '693748be-7c18-39c3-af2e-2e62092090cf',
          kind: :release
        }
      },
      brainz_release_group_arise:              {
        class_name: 'TestData::BrainzService',
        arguments:  {
          code: '5fc9ba9d-bc39-38fc-a479-eadbf0f3a933',
          kind: :release_group
        }
      }
    }.freeze

    def self.call(name)
      new(name).call
    end

    def initialize(name)
      @name = name
    end

    attr_reader :name

    def call
      raise ArgumentError, "can't get instructions for #{name}" \
        unless CLASS_AND_ARGUMENTS_FOR[name]

      class_name.call(**arguments)
    end

    def class_name
      CLASS_AND_ARGUMENTS_FOR[name][:class_name].constantize
    end

    def arguments
      CLASS_AND_ARGUMENTS_FOR[name][:arguments]
    end
  end
end

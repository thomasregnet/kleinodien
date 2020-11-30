# frozen_string_literal: true

require 'fake_music_brainz'
require 'webmock'

namespace :db do
  desc 'fill the database with sample data'
  task populate: :environment do
    password = 'topSecret'

    user = User.create!(
      email:                 'user@example.com',
      importer:              true,
      password:              password,
      password_confirmation: password
    )

    BrainzReleaseImportOrder.create!(
      code:  '7452f8c9-f9bc-3ca7-859e-3220e57e4e4a', # Sepultura - Arise
      state: 'pending',
      user:  user
    )

    BrainzReleaseImportOrder.create!(
      # Iron Maiden - Powerslave
      code:  '58e6a3d6-bbbd-4864-983b-e468a5a1a71c',
      state: 'pending',
      user:  user
    )

    # TODO: use this if you need to populate users
    # 99.times do
    #   User.create!(
    #     email:                 Faker::Internet.email,
    #     password:              password,
    #     password_confirmation: password
    #   )
    # end
  end
end

# frozen_string_literal: true

# This file should contain all the record creation needed to seed the
# database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside
# the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This method smells of :reek:UtilityFunction
def read_json(file)
  JSON.parse(File.read("db/seeds/#{file}.json"), symbolize_names: true)
end

read_json(:formats).each do |format_attr|
  Format.create!(format_attr)
end

# read_json(:format_details).each do |detail_attr|
#   FormatDetail.create!(detail_attr)
# end

read_json(:medium_formats).each do |format_attr|
  MediumFormat.create!(format_attr)
end

read_json(:import_queues).each do |import_queue_attr|
  ImportQueue.create!(import_queue_attr)
end

# Import XML-data provided by OMDB
class OmdbImporter
  def self.import_movie(xml)
    omdb_movie = KleinodienOmdb.parse_movie(xml)
    movie_head = MovieHead.create!(title: omdb_movie.name)
    import_countries(omdb_movie.countries, movie_head)
    import_departments(omdb_movie.departments, movie_head)
    movie_head
  end

  def self.import_countries(countries, movie_head)
    countries.each do |c|
      movie_head.countries << Country.find_or_create_by(name: c)
    end
  end

  def self.import_departments(departments, movie_head)
    return unless departments
    departments.each do |department|
      job = Job.find_or_create_by(name: department.title)
      department.persons.each { |person| add_credit(person, job, movie_head) }
    end
  end

  def self.add_credit(person, job, movie_head)
    artist_credit = import_person(person)
    movie_head.credits.build(
      artist_credit: artist_credit,
      job:           job,
      role:          person.role
    )
  end

  def self.import_person(person)
    artist_credit = ArtistCredit.find_by(name: person.name)
    unless artist_credit
      artist_credit = ArtistCredit.new
      artist = Artist.find_or_create_by(name: person.name)
      artist_credit.participants.build(
        no:     0,
        artist: artist
      )
    end
    artist_credit
  end
end

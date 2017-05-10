require 'cgi'

# Insert Data received from IMDB
class ImdbImporter
  def self.import_movie(html)
    doc = Nokogiri::HTML(html)
    MovieHead.create!(
      title:  title(doc),
      #source: Source::User
    )
  end

  def self.import_tv_serial(html)
    doc = Nokogiri::HTML(html)
    TvSerial.create!(title: title(doc))
  end

  def self.import_tv_serial_season(tv_serial, s_no, html)
    season = tv_serial.seasons.create!(position: s_no)
    doc = Nokogiri::HTML(html)
    doc.search("div.eplist div[@itemprop*='episode']").each do |div|
      create_episode(season, div)
    end
    season
  end

  def self.create_episode(season, div)
    title = div.search("a[@itemprop*='name']").first.content.strip
    position = div.search(
      "meta[@itemprop*='episodeNumber']"
    ).first[:content].to_i
    season.episodes.create!(
      title:    title,
      position: position,
      #source:   Source::User
    )
  end

  def self.title(doc)
    title = doc.at('h1').inner_html.split('<span').first.strip
    CGI.unescapeHTML(title)
  end
end

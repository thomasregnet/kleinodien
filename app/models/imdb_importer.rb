require 'cgi'

class ImdbImporter
  def self.import_movie(html)
    doc = Nokogiri::HTML(html)
    MovieHead.create!(title: title(doc))
  end

  def self.import_tv_serial(html)
    doc = Nokogiri::HTML(html)
    TvSerial.create!(title: title(doc))
  end

  def self.import_tv_serial_season(tv_serial, s_no, html)
    season = tv_serial.seasons.create!(no: s_no)
    doc = Nokogiri::HTML(html)
    doc.search("div.eplist div[@itemprop*='episode']").each do |div|
      link = div.search("a[@itemprop*='name']").first
      season.episodes.create!(
        title: link.content.strip,
        no:    div.search("meta[@itemprop*='episodeNumber']")
          .first[:content].to_i)
    end
    season
  end

  def self.title(doc)
    title = doc.at('h1').inner_html.split('<span').first.strip
    CGI.unescapeHTML(title)
  end
end

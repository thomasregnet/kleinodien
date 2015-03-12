require 'cgi'

class ImdbImporter < ActiveRecord::Base
  def self.import_movie(html)
    doc = Nokogiri::HTML(html)
    MovieHead.create!(title: title(doc))
  end

  def self.import_tv_serial(html)
    doc = Nokogiri::HTML(html)
    TvSerial.create!(title: title(doc))
  end

  def self.import_tv_serial_season(tv_serial, s_no, html)
    season = tv_serial.seasons.create!(no: s_no, type: 'Season')
    doc = Nokogiri::HTML(html)
    doc.search("div.eplist div[@itemprop*='episode']").each do |div|
      link = div.search("a[@itemprop*='name']").first
      title = link.content.strip
      e_no = div.search("meta[@itemprop*='episodeNumber']").first[:content].to_i
      epi = season.episodes.create!(
        title: title,
        no: e_no
      )
      puts epi
    end
    season
  end
  
  def self.title(doc)
    title = doc.at('h1').inner_html.split('<span').first.strip
    title = CGI.unescapeHTML(title)
  end
end

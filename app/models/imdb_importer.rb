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

  def self.title(doc)
    title = doc.at('h1').inner_html.split('<span').first.strip
    title = CGI.unescapeHTML(title)
  end
end

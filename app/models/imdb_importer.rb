require 'cgi'

class ImdbImporter < ActiveRecord::Base
  def self.import_movie(html)
    doc = Nokogiri::HTML(html)
    title = doc.at('h1').inner_html.split('<span').first.strip
    title = CGI.unescapeHTML(title)
    MovieHead.create!(title: title)
  end

  def self.import_serial_data(html)
  end
end

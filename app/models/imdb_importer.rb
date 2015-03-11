require 'cgi'

class ImdbImporter < ActiveRecord::Base
  def self.import_movie(html)
    doc = Nokogiri::HTML(html)
    #byebug
    title = doc.at('h1').inner_html.split('<span').first.strip
    title = CGI.unescapeHTML(title)
    movie_head = MovieHead.new(title: title)
  end
end

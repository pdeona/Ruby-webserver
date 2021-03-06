require 'nokogiri'
require 'open-uri'

module Nokogiri
  module XML
    class Element
      def self.clean_up element, *html_classes
        html_classes.each do |html_class|
          element.xpath("//*[@class=#{html_class}]").remove
        end
        element
      end
    end
  end
end

class CraigslistScraper
  attr_reader :url
  def initialize url="https://miami.craigslist.org/search/sof"
    if url.is_a? String
      @url = url
    else
      raise ArgumentError
    end
  end

  def change_field query_string
    if query_string.length == 3
      @url = "https://miami.craigslist.org/search/".<<(query_string)
    else
      raise ArgumentError
    end
  end

  def scrape log_name
    dom = Nokogiri::HTML(open(@url))
    scrape_log = File.new("#{log_name}.html", "w+")
    dom.css('li[class=result-row]').each_with_index { |element, i| 
      Nokogiri::XML::Element.clean_up(element, "\'restore-link\'", "\'result-meta\'", "\'icon icon-star\'")
      element = element.to_s.chomp
      element.gsub!('<a href="', '<a href="http://miami.craigslist.org')
      # puts element+"<br>"
      scrape_log.print "#{i.+(1)}:"+element+"<br>"
    }
  end
end
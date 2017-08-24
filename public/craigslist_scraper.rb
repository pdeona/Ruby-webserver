require 'nokogiri'
require 'open-uri'

module CraigslistScraper
  class Scraper
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

    def scrape
      dom = Nokogiri::HTML(open(@url))
      # time = Time.new
      # mm = time.month
      # dd = time.day
      # yy = time.year % 100
      scrape_log = File.new("job_log_today.html", "w+")
      dom.css('li[class=result-row]').each_with_index { |element, i| 
        element.xpath("//*[@class='restore-link']").remove
        element.xpath("//*[@class='result-meta']").remove
        element = element.to_s.chomp
        element.gsub!('<a href="', '<a href="http://miami.craigslist.org')
        # puts element+"<br>"
        scrape_log.puts "#{i.+(1)}. "+element+"<br>"
      }
    end
  end
end

CraigslistScraper::Scraper.new.scrape
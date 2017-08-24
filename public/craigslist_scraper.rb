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

    def scrape
      dom = Nokogiri::HTML(open(@url))
      # time = Time.new
      # mm = time.month
      # dd = time.day
      # yy = time.year % 100
      scrape_log = File.new("job_log_today.html", "w+")
      dom.css('li[data-pid]').each_with_index { |element, i| 
        scrape_log.puts "#{i.+(1)}."+listing
      }
    end
  end
end

CraigslistScraper::Scraper.new.scrape
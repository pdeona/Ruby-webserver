require 'nokogiri'
require 'open-uri'

module CraigslistScraper

  class Scraper
    attr_reader :url
    def initialize url="https://miami.craigslist.org/search/jjj"
      if url.is_a? String
        @url = url
      else
        raise ArgumentError
      end
    end

    def scrape
      dom = Nokogiri::HTML(open(@url))
      time = Time.new
      mm = time.month
      dd = time.day
      yy = time.year % 100
      scrape_log = File.new("public/job_log_#{mm}#{dd}#{yy}.html", "w")
      p dom.css('li[data-pid]').each {|i| scrape_log.puts i}
    end
  end
end
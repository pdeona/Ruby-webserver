require 'sinatra'
require_relative 'public/craigslist_scraper'

get '/' do
  job = params[:job]
  url = "https://miami.craigslist.org/search/"
  url.<<(job) unless job.nil?
  unless url == "https://miami.craigslist.org/search/"
    CraigslistScraper::Scraper.new(url).scrape
  else
    CraigslistScraper::Scraper.new.scrape
  end
  send_file File.expand_path('job_log_today.html', settings.root)
end

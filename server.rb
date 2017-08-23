require 'sinatra'
require_relative 'public/craigslist_scraper'

get '/jobs' do
  category = params[:category]
  url = "https://miami.craigslist.org/search/"
  url.<<(category)
  unless category.nil?
    CraigslistScraper::Scraper.new(url).scrape
  else
    CraigslistScraper::Scraper.new.scrape
  end
  send_file File.expand_path('job_log_today.html', settings.public_folder)
end

get '/sinatra' do
  "Hello Sinatra"
end
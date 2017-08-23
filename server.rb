require 'sinatra'
require_relative 'public/craigslist_scraper'

get '/jobs' do
  CraigslistScraper::Scraper.new.scrape
  send_file File.expand_path('job_log_82317.html', settings.public_folder)
end

get '/sinatra' do
  "Hello Sinatra"
end
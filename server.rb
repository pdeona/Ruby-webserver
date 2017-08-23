require 'sinatra'
require_relative 'public/craigslist_scraper'

get '/jobs' do
  CraigslistScraper::Scraper.new.scrape
  redirect '/job_log_82317.html'
end

get '/sinatra' do
  "Hello Sinatra"
end
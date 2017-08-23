require 'sinatra'
require_relative 'craigslist_scraper'

get '/jobs' do
  File.read(CraigslistScraper::Scraper.new.scrape)
end

get '/sinatra' do
  "Hello Sinatra"
end
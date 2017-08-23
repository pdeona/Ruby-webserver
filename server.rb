require 'sinatra'
require_relative 'craigslist_scraper'

get '/' do
  File.read(CraigslistScraper::Scraper.new.scrape)
end

get '/sinatra' do
  "Hello Sinatra"
end
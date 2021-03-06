require 'sinatra'
require_relative 'craigslist_scraper'

get '/' do
  File.open(File.join("public", "hello.html"))
end

get '/jobs' do
  time = Time.new
  mm = time.month
  dd = time.day
  yy = time.year % 100
  log_name = "job_log_%02d#{dd}#{yy}" % mm
  job = params[:job]
  url = "https://miami.craigslist.org/search/"
  url.<<(job) unless job.nil?
  unless url == "https://miami.craigslist.org/search/"
    CraigslistScraper.new(url).scrape(log_name)
  else
    CraigslistScraper.new.scrape(log_name)
  end
  send_file File.expand_path(log_name.<<('.html'), settings.root)
end
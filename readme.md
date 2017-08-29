## Ruby Server/CraigslistScraper

This is a ruby server built on Sinatra and Nokogiri. The root will display a landing page with a search field. It allows users to specify a category for search according to craigslist's job category abbreviations, eg. `hea` = "healthcare jobs", `sof` = "software jobs". If the field is left blank it will return software jobs by default. 

To run navigate to the server directory and execute `ruby server.rb`.
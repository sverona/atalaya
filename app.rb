require 'sinatra'

require 'simple-rss'
require 'open-uri'


def get_feeds(list)
  feeds = []

  File.open(list) do |f|
    urls = f.read
    p urls
    urls = urls.split "\n"

    urls.each do |url|
      feeds.push get_feed(url)
    end
  end

    return feeds
end

def get_feed(url)
  SimpleRSS.parse open(url)
end

$feeds = get_feeds "feeds.txt"

Thread.new do
  while true do
    sleep 60
    $feeds = get_feeds "feeds.txt"
  end
end

get '/' do
  erb(:index)
end

require 'net/http'

module Rss
  class Downloader
    def initialize(url)
      @url = url
    end

    def download!
      response = Net::HTTP.get_response(parsed_uri)

      if response.code == '200'
        response.body
      else
        raise "Feed #{url} could not be downloaded"
      end
    end

    private

    def parsed_uri
      URI.parse(@url)
    end
  end
end

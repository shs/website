module Rss
  class Importer
    def initialize(model, url)
      @model = model
      @url   = url
    end

    def import!
      Parser.new(Downloader.new(@url).download!).entries.each do |item|
        @model.create!(item.to_hash) unless @model.class.uuids.include?(item.uuid)
      end
    end
  end
end

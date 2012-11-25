module Rss
  class Importer
    def initialize(model)
      @source = model.source
      @items  = model.items
      @url    = model.url
    end

    def import!
      Parser.new(Downloader.new(@url).download!).entries.each do |item|
        @items.create!(item.to_hash.merge(:source => @source)) unless @items.class.uuids.include?(item.uuid)
      end
    end
  end
end

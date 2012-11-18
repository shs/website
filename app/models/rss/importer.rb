module Rss
  class Importer
    def initialize(model, url)
      @model = model
      @url   = url
    end

    def import!
      items.each do |item|
        unless uuids.include?(item.uuid)
          attributes = {
            :uuid        => item.uuid,
            :title       => item.title,
            :description => item.description,
            :link        => item.link,
            :date        => item.date
          }

          @model.create!(attributes)
        end
      end
    end

    private

    def items
      @items ||= Parser.new(Downloader.new(@url).download!).entries
    end

    def uuids
      @uuids ||= @model.class.uuids
    end
  end
end

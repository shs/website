require 'nokogiri'

module Rss
  class Parser
    class Entry < OpenStruct; end

    def initialize(xml)
      @xml = xml
    end

    def entries
      @entries ||= feed.xpath('//item').each_with_object([]) do |item, array|
        attributes = {
          :uuid        => Digest::SHA1.hexdigest(item.at('guid').text),
          :title       => item.at('title').text,
          :description => item.at('description').text,
          :link        => item.at('link').text,
          :date        => item.at('pubDate').text
        }

        array << Entry.new(attributes)
      end
    end

    def count
      entries.count
    end

    private

    def feed
      @feed ||= Nokogiri::XML(@xml) { |config| config.strict.nonet }
    rescue Nokogiri::XML::SyntaxError
      raise "XML feed is not valid XML"
    end
  end
end

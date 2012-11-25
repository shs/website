class NewsSource
  class Storage
    class << self; attr_reader :list; end

    def self.add(entry)
      @list ||= {}
      @list.merge!(entry.name => entry)
    end

    def self.get(name)
      @list[name]
    end
  end

  class Record < Struct.new(:name, :url); end

  {
    :modding_news => 'http://forums.gibberlings3.net/index.php?app=core&module=global&section=rss&type=forums&id=1',
    :shs_news     => 'http://www.shsforums.net/index.php?app=core&module=global&section=rss&type=forums&id=2'
  }.each do |name, url|
    Storage.add(Record.new(name, url))
  end

  def self.find(name)
    new(Storage.get(name))
  end

  def initialize(record)
    @record = record
  end

  def items
    NewsItem.where(:source => @record.name.to_s)
  end

  def import!
    importer.import!
  end

  def importer
    @importer ||= Rss::Importer.new(@record)
  end
end

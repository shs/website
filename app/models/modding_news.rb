class ModdingNews < ActiveRecord::Base
  URL = 'http://forums.gibberlings3.net/index.php?app=core&module=global&section=rss&type=forums&id=1'

  validates :uuid, :title, :description, :link, :date, :presence => true
  validates :uuid, :uniqueness => true

  def self.uuids

  end

  def self.import_news!
    Rss::Importer.new(self, URL).import!
  end
end

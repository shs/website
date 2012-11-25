class NewsItem < ActiveRecord::Base
  validates :uuid, :title, :description, :link, :date, :presence => true
  validates :uuid, :uniqueness => true

  def self.uuids

  end
end

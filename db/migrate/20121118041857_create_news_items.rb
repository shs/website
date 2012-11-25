class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :source, :uuid, :title, :link, :null => false
      t.text :description, :null => false
      t.timestamp :date, :null => false
      t.timestamps
    end
  end
end

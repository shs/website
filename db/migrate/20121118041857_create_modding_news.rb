class CreateModdingNews < ActiveRecord::Migration
  def change
    create_table :modding_news do |t|
      t.string :uuid, :title, :link, :null => false
      t.text :description, :null => false
      t.timestamp :date, :null => false
      t.timestamps
    end
  end
end

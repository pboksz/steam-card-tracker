class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :link_url
      t.string :image_url
      t.boolean :foil
      t.integer :game_id

      t.timestamps
    end
  end
end

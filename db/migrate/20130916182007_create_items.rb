class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :link_url
      t.text :image_url
      t.boolean :foil
      t.integer :game_id
      t.string :currency_symbol, :default => '$'

      t.timestamps
    end
  end
end

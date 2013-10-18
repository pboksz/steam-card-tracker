class RemoveUnusedFieldsFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :foil
    remove_column :items, :link_url
    remove_column :items, :image_url
    remove_column :items, :currency_symbol
  end
end

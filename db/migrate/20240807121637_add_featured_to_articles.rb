class AddFeaturedToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :featured, :boolean, default: false
    add_index :articles, :featured, unique: true, where: "featured = true"
  end
end

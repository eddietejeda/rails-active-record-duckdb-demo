class AddCategoryToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :category, :string
    add_column :posts, :featured, :boolean
  end
end

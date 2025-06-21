class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.string :status
      t.integer :view_count
      t.decimal :rating
      t.datetime :published_at

      t.timestamps
    end
  end
end

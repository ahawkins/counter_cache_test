class CreateModels < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.timestamps
      t.string :title
      t.integer :comments_count, :default => 0
    end

    create_table :comments do |t|
      t.timestamps
      t.text :text
      t.references :post
    end
  end

  def down
    drop_table :posts
    drop_table :comments
  end
end

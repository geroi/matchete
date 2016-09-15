class AddCommentsWithAuthor < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.integer :messagable_id
      t.integer :author_id      
      t.string  :messagable_type
      t.timestamps null: false
    end

    add_index :comments, [:messagable_type, :messagable_id]
    add_index :comments, :author_id
  end
end

class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :text
      t.integer :votes

      t.timestamps
    end
  end
end

class AddContentToReplies < ActiveRecord::Migration[7.2]
  def change
    add_column :replies, :content, :text
  end
end

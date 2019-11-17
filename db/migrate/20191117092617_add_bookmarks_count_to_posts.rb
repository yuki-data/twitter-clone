class AddBookmarksCountToPosts < ActiveRecord::Migration[5.2]
  def self.up
    add_column :posts, :bookmarks_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :posts, :bookmarks_count
  end
end

class ChangeShortenedCountDefaultOnUrls < ActiveRecord::Migration
  def up
    change_column :urls, :shortened_count, :integer, :default => 0, :null => false
  end

  def down
  end
end

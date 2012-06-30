class AddShortenedCountToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :shortened_count, :integer
  end
end

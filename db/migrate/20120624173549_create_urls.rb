class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :full_url
      t.string :short_url
      t.integer :redirect_count

      t.timestamps
    end
  end
end

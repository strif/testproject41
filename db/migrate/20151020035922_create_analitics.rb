class CreateAnalitics < ActiveRecord::Migration
  def change
    create_table :analitics do |t|
      t.string :query
      t.integer :impressions
      t.integer :clicks
      t.decimal :ctr, precision: 5, scale: 2
      t.decimal :avg_position, precision: 5, scale: 2
      t.date :date
      t.boolean :new, default: false

      t.timestamps null: false
    end
  end
end

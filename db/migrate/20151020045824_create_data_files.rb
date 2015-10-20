class CreateDataFiles < ActiveRecord::Migration
  def change
    create_table :data_files do |t|
      t.string :name
      t.string :file

      t.timestamps null: false
    end
  end
end

class CreateDataFiles < ActiveRecord::Migration
  def change
    create_table :data_files do |t|
      t.string :name
      t.string :content_type
      t.string :file_size
      t.string :file
      t.timestamps
    end
  end
end

class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.belongs_to :data_file
      t.boolean :indexed
    end
  end
end

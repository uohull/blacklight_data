class CreateDatasetHeaderProps < ActiveRecord::Migration
  def change
    create_table :dataset_header_props do |t|
      t.string :name
      t.boolean :searchable
      t.boolean :displayable
      t.boolean :facetable
      t.boolean :multivalued
      t.boolean :sortable
      t.string :data_type
      t.belongs_to :dataset, index: true
      t.timestamps
    end
  end
end
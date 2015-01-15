class CreateBlacklightConfigurations < ActiveRecord::Migration
  def change
    create_table :blacklight_configurations do |t|
      t.string :configuration
      t.string :label
      t.string :solr_field
      t.boolean :enabled 
      t.belongs_to :dataset, index: true
      t.timestamps
    end
  end
end

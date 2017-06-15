class AddTerrainInformation < ActiveRecord::Migration[5.1]
  def change
  	add_column :terrains, :nom, :string
  	add_column :terrains, :description, :string
  	add_column :terrains, :surface, :string
	change_table :terrains do |t|
		t.integer :club_id
	end

  end
end

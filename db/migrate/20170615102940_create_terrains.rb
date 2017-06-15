class CreateTerrains < ActiveRecord::Migration[5.1]
  def change
    create_table :terrains do |t|

      t.timestamps
    end
  end
end

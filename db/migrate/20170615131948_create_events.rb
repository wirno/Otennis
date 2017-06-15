class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
    	t.string :title
    	t.datetime :start
    	t.datetime :end
    	t.string :color
    	t.integer :current
    	t.integer :user_id
    	t.integer :terrain_id
    	t.timestamps
    end
  end
end

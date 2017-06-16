class AddClubInformation < ActiveRecord::Migration[5.1]
  def change
  	add_column :clubs, :nom, :string
  	add_column :clubs, :ville, :string
  	add_column :clubs, :cp, :string
  	add_column :clubs, :adresse, :string
  	add_column :clubs, :description, :string
  	add_column :clubs, :avatar, :string
  	add_column :clubs, :telephone, :string
  end
end

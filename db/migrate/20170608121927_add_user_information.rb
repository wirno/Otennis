class AddUserInformation < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :nom, :string
  	add_column :users, :prenom, :string
  	add_column :users, :age, :date
    add_column :users, :genre, :string
  	add_column :users, :cp, :string
  	add_column :users, :ville, :string
  	add_column :users, :tennislevel, :string
    add_column :users, :anneetennis, :integer
  	add_column :users, :cote, :integer
  	add_column :users, :note, :string
  	add_column :users, :victoire, :integer
  	add_column :users, :defaite, :integer
  	add_column :users, :avatar, :string
  end
end

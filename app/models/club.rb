class Club < ApplicationRecord
  has_many :terrains
  
	include AlgoliaSearch
  	algoliasearch auto_index: true, auto_remove: true do
    	attribute :nom, :ville, :cp, :adresse, :description
    	searchableAttributes ['unordered(nom)', 'unordered(adresse)', 'unordered(cp)', 'unordered(ville)']
    	customRanking ['asc(nom)']
	end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

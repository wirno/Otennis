class Terrain < ApplicationRecord
	belongs_to :club
    has_many :events

	include AlgoliaSearch
  	algoliasearch auto_index: true, auto_remove: true do
    	attribute :nom, :description, :surface
    	attribute :club do
    		{ nom: club.nom, ville: club.ville, cp: club.cp, adresse: club.adresse, description: club.description }
    	end

    	searchableAttributes ['unordered(nom)', 'unordered(surface)']
    	customRanking ['asc(nom)']
	end
end

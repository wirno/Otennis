class User < ApplicationRecord


	include AlgoliaSearch
  	algoliasearch auto_index: true, auto_remove: true do
    	attribute :nom, :prenom, :age, :genre, :email, :cp, :ville, :tennislevel, :anneetennis, :avatar
    	searchableAttributes ['unordered(cp)', 'unordered(ville)', 'unordered(tennislevel)', 'unordered(anneetennis)', 'unordered(genre)', 'unordered(nom)', 'unordered(prenom)', 'unordered(email)']
    	customRanking ['asc(email)']
	end

	mount_uploader :avatar, AvatarUploader
	attr_accessor :avatar_cache
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

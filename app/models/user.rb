class User < ApplicationRecord
  has_many :events

	include AlgoliaSearch
  	algoliasearch auto_index: true, auto_remove: true do
    	attribute :nom, :prenom, :age, :pseudo, :genre, :email, :cp, :ville, :tennislevel, :anneetennis, :avatar
    	searchableAttributes ['unordered(cp)', 'unordered(ville)', 'unordered(tennislevel)', 'unordered(anneetennis)', 'unordered(genre)', 'unordered(pseudo)', 'unordered(nom)', 'unordered(prenom)', 'unordered(email)']
    	customRanking ['asc(email)']
      add_attribute :calcAge
	end

  def calcAge
    dob = "#{age}".to_time
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

	mount_uploader :avatar, AvatarUploader
	attr_accessor :avatar_cache
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

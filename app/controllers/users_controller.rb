require 'httparty'
class UsersController < ApplicationController
	def matchmaking 
	  	if user_signed_in?
	  		@currentUser = current_user
	  		city = @currentUser.ville
	  		gender = @currentUser.genre
	  		responseCityLatLong = HTTParty.get("http://maps.googleapis.com/maps/api/geocode/json?address={" + city + "},{FR}", :verify => false)
	  		latitude = responseCityLatLong['results'][0]['geometry']['location']['lat']
	  		longitude = responseCityLatLong['results'][0]['geometry']['location']['lng']

	  		nearbyCities = HTTParty.get("http://api.geonames.org/findNearbyPlaceNameJSON?lat=#{latitude}&lng=#{longitude}&radius=10&username=mlivet")
	  		citiesArray = []
	  		nearbyCities['geonames'].each do |detailsCity|
	  			citiesArray << detailsCity['name']
	  		end

	  		arrayUserSearchByCity = []
	  		citiesArray.each do |city|
	  			resultsUsersSearchByCity = User.raw_search(city)
	  			resultsUsersSearchByCity['hits'].each do |user|
	  				if(@currentUser.id != user['objectID'].to_i)
	  					arrayUserSearchByCity << user['objectID'].to_i
	  				end
	  			end
	  		end

	  		arrayUserSearchByGender = []
	  		resultsUsersSearchByGender = User.raw_search(gender)
	  		resultsUsersSearchByGender['hits'].each do |user|
	  			if(@currentUser.id != user['objectID'].to_i)
	  				arrayUserSearchByGender << user['objectID'].to_i
	  			end
	  		end

	  		usersArray = arrayUserSearchByCity & arrayUserSearchByGender

	  		@users = User.where(id: usersArray)

	  	else
	  		redirect_to new_user_session_path, notice: 'vous devez être connecté'
	  	end
	end

	def profile
		@user = current_user
	end

	def show
		@user = User.find_by_id(params[:id])
	end
end

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

	def settings
		@users = User.all
	end

	def parameters
		if(filters_params['radius'].present? && !filters_params['radius'].blank? && filters_params['ville'].present? && !filters_params['ville'].blank?)
			radius = filters_params['radius']
			city = filters_params['ville']
			arrayUserSearchByCity = []

			responseCityLatLong = HTTParty.get("http://maps.googleapis.com/maps/api/geocode/json?address={" + city + "},{FR}", :verify => false)
	  		latitude = responseCityLatLong['results'][0]['geometry']['location']['lat']
	  		longitude = responseCityLatLong['results'][0]['geometry']['location']['lng']

	  		nearbyCities = HTTParty.get("http://api.geonames.org/findNearbyPlaceNameJSON?lat=#{latitude}&lng=#{longitude}&radius=#{radius}&username=mlivet")
	  		citiesArray = []
	  		nearbyCities['geonames'].each do |detailsCity|
	  			citiesArray << detailsCity['name']
	  		end
	  		citiesArray.each do |city|
	  			resultsUsersSearchByCity = User.raw_search(city)
	  			resultsUsersSearchByCity['hits'].each do |user|
	  				if(current_user.id != user['objectID'].to_i)
	  					arrayUserSearchByCity << user['objectID'].to_i
	  				end
	  			end
	  		end
		end

		if(filters_params['sexe'].present? && !filters_params['sexe'].blank?)
			sexe = filters_params['sexe']
	  		arrayUserSearchByGender = []

	  		resultsUsersSearchByGender = User.raw_search(sexe)
	  		resultsUsersSearchByGender['hits'].each do |user|
	  			if(current_user.id != user['objectID'].to_i)
	  				arrayUserSearchByGender << user['objectID'].to_i
	  			end
	  		end
		end

		if((filters_params['age1'].present? && !filters_params['age1'].blank?) || (filters_params['age2'].present? && !filters_params['age2'].blank?))
			arrayUserSearchByAge = []
			if(filters_params['age1'].present? && !filters_params['age1'].blank? && filters_params['age2'].present? && !filters_params['age2'].blank?)
				age1 = filters_params['age1'].to_i
				age2 = filters_params['age2'].to_i

				resultsUsersSearchByAge = User.raw_search('', {
			  		numericFilters: [
			    		"calcAge > #{age1}",
			    		"calcAge < #{age2}"
			  	]})

			  	resultsUsersSearchByAge['hits'].each do |user|
	  				if(current_user.id != user['objectID'].to_i)
	  					arrayUserSearchByAge << user['objectID'].to_i
	  				end
	  			end

			elsif (filters_params['age1'].present? && !filters_params['age1'].blank?)
				age1 = filters_params['age1']
				
				resultsUsersSearchByAge = User.raw_search('', {
			  		numericFilters: [
			    		"calcAge >= #{age1}"
			  	]})
			  	resultsUsersSearchByAge['hits'].each do |user|
	  				if(current_user.id != user['objectID'].to_i)
	  					arrayUserSearchByAge << user['objectID'].to_i
	  				end
	  			end
			else
				age2 = filters_params['age2']
				
				resultsUsersSearchByAge = User.raw_search('', {
			  		numericFilters: [
			    		"calcAge >= #{age2}"
			  	]})
			  	resultsUsersSearchByAge['hits'].each do |user|
	  				if(current_user.id != user['objectID'].to_i)
	  					arrayUserSearchByAge << user['objectID'].to_i
	  				end
	  			end	
			end
		end

		if(filters_params['niveau'].present? && !filters_params['niveau'].blank?)
			niveau = filters_params['niveau']
			arrayUserSearchByLevel = []

			resultsUsersSearchByLevel = User.raw_search(niveau)
			resultsUsersSearchByLevel['hits'].each do |user|
				if(current_user.id != user['objectID'].to_i)
			  		arrayUserSearchByLevel << user['objectID'].to_i
			  	end
			end
		end

		usersArray = User.ids
		if(filters_params['radius'].present? && !filters_params['radius'].blank? && filters_params['ville'].present? && !filters_params['ville'].blank?)
			usersArray = usersArray & arrayUserSearchByCity
		end

		if(filters_params['sexe'].present? && !filters_params['sexe'].blank?)
			usersArray = usersArray & arrayUserSearchByGender
		end

		if((filters_params['age1'].present? && !filters_params['age1'].blank?) || (filters_params['age2'].present? && !filters_params['age2'].blank?))
			usersArray = usersArray & arrayUserSearchByAge
		end

		if(filters_params['niveau'].present? && !filters_params['niveau'].blank?)
			usersArray = usersArray & arrayUserSearchByLevel
		end

		@users = User.where(id: usersArray)
	end

	def filters_params
		params.require(:filters).permit(:radius, :ville, :sexe, :age1, :age2, :niveau)
	end
end

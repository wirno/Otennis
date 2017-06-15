class ClubsController < ApplicationController
	def profile
		@club = current_club
		@terrains = @club.terrains
	end

	def show
		if(Club.find_by_id(params[:id]))
			@club = Club.find_by_id(params[:id])
			@terrains = @club.terrains
		else
			redirect_to root_path, notice: 'Ce club n\'existe pas'
		end
	end

	def createterrains
		@club = current_club
		@terrain = Terrain.new(paramterrain_params)
		@terrain.club = @club 
		if(@terrain.save)
			redirect_to clubs_profile_path, notice: 'Le terrain a été sauvegarder avec succés'
		else
			redirect_to clubs_profile_path, notice: 'il y a eu un problème avec la sauvegarde du terrain'
		end

	end

	def settings
		@clubs = Club.all
	end

	def search
		if(filters_params['radius'].present? && !filters_params['radius'].blank? && filters_params['ville'].present? && !filters_params['ville'].blank?)
			radius = filters_params['radius']
			city = filters_params['ville']
			arrayClubSearchByCity = []

			responseCityLatLong = HTTParty.get("http://maps.googleapis.com/maps/api/geocode/json?address={" + city + "},{FR}", :verify => false)
	  		latitude = responseCityLatLong['results'][0]['geometry']['location']['lat']
	  		longitude = responseCityLatLong['results'][0]['geometry']['location']['lng']

	  		nearbyCities = HTTParty.get("http://api.geonames.org/findNearbyPlaceNameJSON?lat=#{latitude}&lng=#{longitude}&radius=#{radius}&username=mlivet")
	  		citiesArray = []
	  		nearbyCities['geonames'].each do |detailsCity|
	  			citiesArray << detailsCity['name']
	  		end
	  		citiesArray.each do |city|
	  			resultsClubsSearchByCity = Club.raw_search(city)
	  			resultsClubsSearchByCity['hits'].each do |user|
	  				arrayClubSearchByCity << user['objectID'].to_i
	  			end
	  		end
	  		puts arrayClubSearchByCity
		end

		if(filters_params['nom'].present? && !filters_params['nom'].blank?)
			club = filters_params['nom']
	  		arrayClubSearchByName = []

	  		resultsClubsSearchByName = Club.raw_search(club)
	  		resultsClubsSearchByName['hits'].each do |user|
	  			arrayClubSearchByName << user['objectID'].to_i
	  		end
		end

		clubsArray = Club.ids
		if(filters_params['radius'].present? && !filters_params['radius'].blank? && filters_params['ville'].present? && !filters_params['ville'].blank?)
			clubsArray = clubsArray & arrayClubSearchByCity
		end

		if(filters_params['nom'].present? && !filters_params['nom'].blank?)
			clubsArray = clubsArray & arrayClubSearchByName
		end

		@clubs = Club.where(id: clubsArray)

	end

	def paramterrain_params
		params.require(:paramterrain).permit(:nom, :description, :surface)
	end

	def filters_params
		params.require(:filters).permit(:nom, :ville, :radius)
	end
end

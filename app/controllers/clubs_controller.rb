class ClubsController < ApplicationController
	def profile
		@club = current_club
		@terrains = @club.terrains
	end

	def show
		@club = Club.find_by_id(params[:id])
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
	end

	def search
	end

	def paramterrain_params
		params.require(:paramterrain).permit(:nom, :description, :surface)
	end
end

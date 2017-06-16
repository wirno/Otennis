class TerrainsController < ApplicationController
	def show
		if(Terrain.find_by_id(params[:id]))
			@terrain = Terrain.find_by_id(params[:id])
			session[:search_terrain_id] = @terrain.id
		else
			redirect_to root_path, notice: 'Ce terrain n\'existe pas'
		end
	end

	def destroy
		@terrain = Terrain.find(params[:id])
		puts @terrain
		if(@terrain.destroy)
			redirect_to  clubs_profile_path, notice: 'Le terrain a été supprimé'
		else
			redirect_to  clubs_profile_path, notice: 'Le terrain n\'a pas pu être supprimé'
		end
  end
end

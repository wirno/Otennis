class TerrainsController < ApplicationController
	def show
		if(Terrain.find_by_id(params[:id]))
			@terrain = Terrain.find_by_id(params[:id])
			session[:search_terrain_id] = @terrain.id
		else
			redirect_to root_path, notice: 'Ce terrain n\'existe pas'
		end
	end
end

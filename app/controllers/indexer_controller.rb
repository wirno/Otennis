class IndexerController < ApplicationController
	def index
	end
	
	def reindex
	  	User.reindex
	  	Club.reindex
	  	Terrain.reindex
	  	render :nothing => true, :status => 200, :content_type => 'text/html'
  	end
end

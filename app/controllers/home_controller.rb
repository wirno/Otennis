class HomeController < ApplicationController
	def index
		@toto = 'je suis dans HomeController et la fonction index'
		#reset_session
	end
end

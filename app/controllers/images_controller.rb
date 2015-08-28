class ImagesController < ApplicationController

	def new
	end
	def index
		@images = Image.all 

		@images.each do | val |

			iamgename = val.class
		end
	end

	def show
	
	 @images = Image.all 
    end

	def update
	end

	def destroy
	end

	

	
end

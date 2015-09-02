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
	 @ip = "48"
	
		respond_to do |format|
		    format.html
		    format.json  { render :json => @images }
	    end

    end

	def update
	end

	def destroy
	end

	

	
end

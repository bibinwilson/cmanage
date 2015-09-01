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

	  post= RestClient.post "http://52.26.184.66:4243/containers/create", { 
        "Image" => "httpd",
        "ExposedPorts" => {
               "22/tcp" => {},
               "80/tcp" => {}
       }

      }.to_json, :content_type => :json, :accept => :json

      status = JSON.parse(post)
      c_id = status["Id"]
      RestClient.post "http://52.26.184.66:4243/containers/#{c_id}/start"
    end

	def update
	end

	def destroy
	end

	

	
end

class HostController < ApplicationController
  def new
  end



  def create
  	@host = Host.new( host_params )
  	if @host.save
         redirect_to @host 
     else
       flash[:error] = "Didn't save"
      render 'hosts'
    end
    
  end
  

   def update_host

    @host = Host.find(params[:id])
    @host.update_attributes(host_update_params)
    if @host.save
      redirect_to @host, flash: {notice: "Successfully checked in"}
    else
      flash[:error] = 'Data Not Saved. Try Again'
      redirect_to @host
    end
    
  end

  def hosts
    @host = Host.new
  	@hosts = Host.all

  end

  def show
  	@host = Host.find(params[:id])
    @hosts = Host.all
    @images = @host.images
    @container = Container.new 

  #   RestClient.get("http://#{@host.ip}:4243/info") { |response, request, result, &block|
        
  #     case response.code
  #     when 200   
  #       @info = JSON.parse(response)
  #     when 500
  #       redirect_to root_path
       
  #      else
  #       response.return!(request, result, &block)
    
  #   end
  # }

  end

  def destroy 

    @host = Host.find(params[:id])

    @host.destroy

    redirect_to hosts_host_index_url

  end

  def new_container

      @host = Host.find(params[:id])
      
      RestClient.post("http://#{@host.ip}:4243/containers/create", { 
        "Image" => "#{params[:name]}",
        "ExposedPorts" => {
               "22/tcp" => {},
               "80/tcp" => {}
       }

      }.to_json, :content_type => :json, :accept => :json){ |response, request, result, &block|
          case response.code
            when 201
              @status = JSON.parse(response)
              RestClient.post("http://#{@host.ip}:4243/containers/#{@status["Id"]}/start", { '' => ""}.to_json, :content_type => :json, :accept => :json){ |response, request, result, &block|
                case response.code
                  when 204
                    puts " hurayyyyy!! started the container"
                  when 304
                    
                  when 404

                  when 500
                   
                  else
                    response.return!(request, result, &block)
          end
    }

            else
              response.return!(request, result, &block)
          end
    }

    
   
   Container.sync_container
      
   redirect_to @host
    
  end



  private

    def host_params
      params.require(:host).permit(:name, :ip)
    end

    def host_update_params
      params.permit(:name, :ip)
    end

       

end


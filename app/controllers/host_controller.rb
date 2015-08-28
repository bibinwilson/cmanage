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

    RestClient.get("http://#{@host.ip}:4243/info") { |response, request, result, &block|
        
      case response.code
      when 200   
        @info = JSON.parse(response)

       else
        response.return!(request, result, &block)
    
    end
  }

  end

  def destroy 

    @host = Host.find(params[:id])

    @host.destroy

    redirect_to hosts_host_index_url

  end

  def new_container

      @host = Host.find(params[:id])
      ip = @host.ip
      post= RestClient.post "http://#{ip}:4243/containers/create", { 'Image' => "#{params[:name]}" 

      }.to_json, :content_type => :json, :accept => :json
      
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


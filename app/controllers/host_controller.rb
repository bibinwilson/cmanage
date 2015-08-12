class HostController < ApplicationController
  def new
  end

  def list
  	@hosts = Host.all
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

  def hosts
  	@host = Host.new
  	@hosts = Host.all

  end

  def show
  	@host = Host.find(params[:id])
    @hosts = Host.all
    @containers = @host.containers
    @container = Container.new
  end

  def destroy 

    @host = Host.find(params[:id])

    @host.destroy

    redirect_to hosts_host_index_url

  end

  def new_container
       
  end

  private

    def host_params
      params.require(:host).permit(:name, :ip)
    end

    def container_params
    end



    

end


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
  	@hosts = Host.find(params[:id])
  end

  private

    def host_params
      params.require(:host).permit(:name, :ip)
    end

end




class DockerController < ApplicationController

  def hosts

  end

  def index 
    @container_count = Container.count
    @host_count = Host.count
  end

  def new

  end

  def containers
    
    @containers = Container.all
    @hosts = Host.all

  
  end

  def sync_containers

    @host = Host.find_by_ip params[:host_id]


    Container.delete_all

     sync = RestClient.get "http://#{params[:host_id]}:4243/containers/json?all=1"
        

     if sync.code.to_i >= 200 && sync.code.to_i < 400 

      @code = sync.code

      @sync = JSON.parse(sync)

      @sync.each do |container| 

        cname = container["Names"]
             
        list = @host.containers.build(:name => cname , :command => container["Command"], :created => container["Created"], :c_id => container["Id"], :image => container["Image"], :ports => "8080", :status => container["Status"])
        list.save

     end

      else
        render 'containers'
     end
  
    
   @containers = Container.all
     @hosts = Host.all
     render 'containers'
    
  end
   
      

  def show

    @container = Container.find(params[:id])


     
   # cinfo = RestClient.get 'http://52.11.9.194:4243/containers/9f2146e058d1cb988ac70b5aae2860518374896deb3ba9c67496b48237fff452/json'
   #  @cinfo = JSON.parse(cinfo)
    
  end



end



class DockerController < ApplicationController

  def hosts

  end

  def index 
    @container_count = Container.count
    @host_count = Host.count
  end

  def containers
    
    @containers = Container.all
    @container = Container.new
    @hosts = Host.all
  
  end

  def sync_containers 

    @host = Host.find_by_ip params[:host_id]
    
     RestClient.get("http://#{params[:host_id]}:4243/containers/json?all=1") { |response, request, result, &block|
        
      case response.code
        when 200   
          @sync = JSON.parse(response)

          @sync.each do |container| 

          cname = container["Names"]
               
          @host.containers.where(:c_id => container["Id"] ).first_or_create(:name => cname , :command => container["Command"], :created => container["Created"], :c_id => container["Id"], :image => container["Image"], :ports => "8080", :status => container["Status"], :flag => "0")
          change = @host.containers.find_by_c_id(container["Id"])
          change.flag="0"
          change.save

        end
        when 500

          redirect_to root_path

         @invalid = @host.containers.all
          @invalid.each do | val |
            cid = val.c_id
            change = @host.containers.find_by_c_id(cid)
            if  change.flag.blank?
                change.destroy
            end
          end
        
      
          @flagset = @host.containers.all
          @flagset.each do | val |
            cid = val.c_id
            change = @host.containers.find_by_c_id(cid)
            change.flag=""
            change.save
          end     

      else
        response.return!(request, result, &block)
    
    end
  }
      
     @containers = Container.all  
     @hosts = Host.all
     Container.sync_container
     render 'containers'
    
  end
       

  def show

    @container = Container.find(params[:id])


    
  end

  def start_container
    @container = Container.find(params[:id])
    @host = Host.find(@container.host_id)
    post= RestClient.post("http://#{@host.ip}:4243/containers/#{@container.c_id}/start", { '' => ""}.to_json, :content_type => :json, :accept => :json){ |response, request, result, &block|
          case response.code
            when 204
              redirect_to docker_path(@container), flash: {notice: "Successfully Made the Start Request"}

            when 304
              redirect_to docker_path(@container), flash: {notice: "Slow Down Howdyy!;( The container is already Running !"}
            when 404

              redirect_to docker_path(@container, id: @container.id), flash: {notice: "Slow Down Howdyy!;( There is no such Container!"}

            when 500

              redirect_to docker_path(@container, id: @container.id), flash: {notice: "Sorry Howdyy!;( Sever has 500 internal error !"}

            else
              response.return!(request, result, &block)
          end
    }
  
  end

  def restart_container
    @container = Container.find(params[:id])
    @host = Host.find(@container.host_id)
    post= RestClient.post "http://#{@host.ip}:4243/containers/#{@container.c_id}/restart", { '' => ""}.to_json, :content_type => :json, :accept => :json
    redirect_to docker_path(@container), flash: {notice: "Successfully Made the ReStart Request"}
  
  end

  def stop_container
    @container = Container.find(params[:id])
    @host = Host.find(@container.host_id)
    RestClient.post("http://#{@host.ip}:4243/containers/#{@container.c_id}/stop", { '' => ""}.to_json, :content_type => :json, :accept => :json){ |response, request, result, &block|
          case response.code
            when 204
             redirect_to docker_path(@container), flash: {notice: "Howdyy!;( The container Has been stopped !"}
            when 304
              redirect_to docker_path(@container), flash: {notice: "Slow Down Howdyy!;( The container is already stopped !"}
            when 404

              redirect_to docker_path(@container, id: @container.id), flash: {notice: "Slow Down Howdyy!;( There is no such Container!"}

            when 304

              redirect_to docker_path(@container, id: @container.id), flash: {notice: "Sorry Howdyy!;( Sever has 500 internal error !"}

            else
              response.return!(request, result, &block)
          end
    }
  
  end

    

  def destroy
    
    @container = Container.find(params[:id])
    @host = Host.find(@container.host_id)
    RestClient.delete("http://#{@host.ip}:4243/containers/#{@container.c_id}", :content_type => :json, :accept => :json) { |response, request, result, &block|
          case response.code
            when 204
             Container.sync_container
             redirect_to host_path(@host),flash: {notice: "Howdyy!;( You have successfull deleted the container!" }
            when 400
              redirect_to docker_path(@container, id: @container.id), flash: {notice: "Sorry Howdyy!;( You gotta check your parameter!"}
            when 404

              redirect_to docker_path(@container, id: @container.id), flash: {notice: "Hey you!! The container doesnt exist on the server!"}

            when 500

              redirect_to docker_path(@container, id: @container.id), flash: {notice: "Sorry Howdyy!;( Sever had a 500 internal error !"}

            else
              response.return!(request, result, &block)
          end
    }
       
  end






 
end

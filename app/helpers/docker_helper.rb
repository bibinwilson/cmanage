module DockerHelper
	

	def show_logs(id)
     
     @containers = Container.find_by_c_id(id)
     @host = Host.find(@container.host_id)
     logs = RestClient.get "http://#{@host.ip}:4243/containers/#{id}/logs?stderr=1&stdout=1"
    
       
     log_data = "#{logs}".to_s.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
     log_data
    
   end


  def show_process(id)
   	 containers = Container.find_by_c_id(id)
     @host = Host.find(@container.host_id)
     RestClient.get("http://#{@host.ip}:4243/containers/#{id}/top") { |response, request, result, &block|
        
      case response.code
        when 500

        log_data = " Unable to fetch processess. Check if Container is running" 
        log_data

      when 200
         log_data = response.to_s.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
         log_data
       else
        response.return!(request, result, &block)
       end
          
    }
    
   end

  
   end

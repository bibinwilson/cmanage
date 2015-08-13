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
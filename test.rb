@sync = JSON.parse(response)

        @sync.each do |container| 

        cname = container["Names"]
             
        list = @host.containers.build(:name => cname , :command => container["Command"], :created => container["Created"], :c_id => container["Id"], :image => container["Image"], :ports => "8080", :status => container["Status"])
        
        list.save
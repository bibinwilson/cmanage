class ImagesController < ApplicationController

	def new
	end

	def sync_images

		@host = Host.find(2)

		RestClient.get("http://50.112.175.68:4243/images/json") { |response, request, result, &block|
	        
	     case response.code
	      when 200   
	        @sync = JSON.parse(response)  
	        sync.each do |image| 

            cname = container["Names"]
             
            list = @host.images.build(:image_id => image["Id"] , :tags => image["RepoTags"], :created => image["Created"], :size => image["Size"], :virtual_size => image["VirtualSize"] )
        
            list.save
        end

	      else
	        response.return!(request, result, &block)
	    
	    end
	  }
		
	end

	def show
		RestClient.get("http://50.112.175.68:4243/images/json") { |response, request, result, &block|
	        
	     case response.code
	      when 200   
	        @sync = JSON.parse(response)  
	      else
	        response.return!(request, result, &block)
	    
	    end
	  }

	  Image.delete_all

	  @host = Host.find(2)

		RestClient.get("http://50.112.175.68:4243/images/json") { |response, request, result, &block|
	        
	     case response.code
	      when 200   
	        @sync = JSON.parse(response)  
	        @sync.each do |image| 
            iname = image["RepoTags"].to_a
            imgname=iname[0]
            vsize = format_mb(image["VirtualSize"])
            
            list = @host.images.build(:image_id => image["Id"] , :tags => imgname, :created => image["Created"], :size => image["Size"], :virtual_size => vsize )
        
            list.save
        end

	      else
	        response.return!(request, result, &block)
	    
	    end
	  }
	end

	def update
	end

	def destroy
	end

	def format_mb(size)
  conv = [ 'b', 'kb', 'mb', 'gb', 'tb', 'pb', 'eb' ];
  scale = 1024;

  ndx=1
  if( size < 2*(scale**ndx)  ) then
    return "#{(size)} #{conv[ndx-1]}"
  end
  size=size.to_f
  [2,3,4,5,6,7].each do |ndx|
    if( size < 2*(scale**ndx)  ) then
      return "#{'%.3f' % (size/(scale**(ndx-1)))} #{conv[ndx-1]}"
    end
  end
  ndx=7
  return "#{'%.3f' % (size/(scale**(ndx-1)))} #{conv[ndx-1]}"
end

	
end

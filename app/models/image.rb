class Image < ActiveRecord::Base

	has_many :containers
	belongs_to :hosts

	def self.sync_images

	@hosts = Host.all

	@hosts.each do | host |
	
		ip = host.ip

		host.images.delete_all

				RestClient.get("http://#{ip}:4243/images/json") { |response, request, result, &block|
			        
			     case response.code
			      when 200   
			        @sync = JSON.parse(response)  
			        @sync.each do |image| 
		            iname = image["RepoTags"].to_a
		            imgname=iname[0]
		            vsize = format_mb(image["VirtualSize"])
		            
		            
		            list = host.images.build(:image_id => image["Id"] , :tags => imgname, :created => image["Created"], :size => image["Size"], :virtual_size => vsize )
		        
		            list.save
		        end

			      else
			        response.return!(request, result, &block)
			    
			    end
			  }
			end
	end

	def self.format_mb(size)
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


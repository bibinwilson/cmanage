class Container < ActiveRecord::Base
  belongs_to :hosts
  belongs_to :images
  validates :id, uniqueness: true 

def self.sync_container

	@hosts = Host.all

	@hosts.each do | host |
	
		ip = host.ip

		host.containers.delete_all
	
		RestClient.get("http://#{ip}:4243/containers/json?all=1") { |response, request, result, &block|
	        
				      case response.code
					      when 200   
					        @sync = JSON.parse(response)

					        @sync.each do |container| 

					        cname = container["Names"]
					             
					        list = host.containers.new(:name => cname , :command => container["Command"], :created => container["Created"], :c_id => container["Id"], :image => container["Image"], :ports => "8080", :status => container["Status"])
					        
					        list.save
					      end
					      else
					        response.return!(request, result, &block)    
				      end
	                }
	end

end

end



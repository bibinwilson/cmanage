class Container < ActiveRecord::Base
  
  belongs_to :hosts
  belongs_to :images
  validates :id, uniqueness: true 

def self.sync_container

	@hosts = Host.all

	@hosts.each do | host |
	
		ip = host.ip

		RestClient.get("http://#{ip}:4243/containers/json?all=1") { |response, request, result, &block|
	        
				      case response.code
					      when 200   
					        @sync = JSON.parse(response)

					        @sync.each do |container| 

					        cname = container["Names"]
       						host.containers.where(:c_id => container["Id"] ).first_or_create(:name => cname , :command => container["Command"], :created => container["Created"], :c_id => container["Id"], :image => container["Image"], :ports => "8080", :status => container["Status"], :flag => "0")
					        change = host.containers.find_by_c_id(container["Id"])
					        change.flag="0"
					        change.status="#{container["Status"]}"
					        change.save
					      end
					      @invalid = host.containers.all
				          @invalid.each do | val |
				            cid = val.c_id
				            change = host.containers.find_by_c_id(cid)
				            if  change.flag.blank?
				                change.destroy
				            end
				          end
				        
				      
				          @flagset = host.containers.all
				          @flagset.each do | val |
				            cid = val.c_id
				            change = host.containers.find_by_c_id(cid)
				            change.flag=""
				            change.save
				          end     

					      else
					        response.return!(request, result, &block)    
				      end
	                }
	end

         
end

end



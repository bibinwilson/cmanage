class Host < ActiveRecord::Base

#has_many :containers, :dependent => :destroy
has_many :images
has_many :containers , :dependent => :destroy

	validates :name, presence: true
	validates :name, uniqueness: true
	validates :ip, presence: true
	validates :ip, uniqueness: true 
end

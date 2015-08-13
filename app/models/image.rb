class Image < ActiveRecord::Base
	has_many :containers
	belongs_to :hosts
end

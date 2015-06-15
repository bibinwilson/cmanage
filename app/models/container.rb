class Container < ActiveRecord::Base
  belongs_to :hosts
  validates :id, uniqueness: true 
end

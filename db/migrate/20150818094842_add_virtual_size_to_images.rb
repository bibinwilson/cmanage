class AddVirtualSizeToImages < ActiveRecord::Migration
  def change
    add_column :images, :virtual_size, :int
  end
end

class AddFlagToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :flag, :int
  end
end

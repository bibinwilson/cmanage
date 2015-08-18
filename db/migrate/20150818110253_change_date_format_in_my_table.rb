class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def up
    change_column :images, :tags, :text
  end

  def down
    change_column :images, :tags, :string
  end
end

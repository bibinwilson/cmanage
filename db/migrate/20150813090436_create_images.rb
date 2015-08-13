class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t| 
    	t.references :host, index: true
    	t.string :image_id
    	t.string :tags
    	t.timestamp :created
    	t.integer :size    	
      t.timestamps
    end
  end
end

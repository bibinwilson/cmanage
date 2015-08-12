class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.references :host, index: true
      t.string :command
      t.string :created
      t.string :c_id
      t.string :image
      t.string :name
      t.string :ports
      t.string :status
      t.timestamps
    end    
  end
end

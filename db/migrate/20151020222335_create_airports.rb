class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :state, null:false
      t.string :name, null:false
      t.string :code, null:false
      t.string :longitude, null:false
      t.string :latitude, null:false
      
      t.timestamps null: false
    end
  end
end

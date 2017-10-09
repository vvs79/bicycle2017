class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.string  :name
      t.text    :description
      t.integer :bike_id
      
      t.timestamps null: false
    end
  end
end

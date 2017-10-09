class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string  :name
      t.text    :description
      t.integer :category_id
      t.text    :used_bike
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :bikes, :name
  end
end

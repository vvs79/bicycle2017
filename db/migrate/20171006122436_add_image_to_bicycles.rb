class AddImageToBicycles < ActiveRecord::Migration
  def change
    add_column :bikes, :images, :text
  end
end

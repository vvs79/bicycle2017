class Comment < ActiveRecord::Base
  validates :name, length: { maximum: 200 }
  validates :description, length: { maximum: 10000 }
  
  belongs_to :bike
  
end

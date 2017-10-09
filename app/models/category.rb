class Category < ActiveRecord::Base
  validates :name, length: { maximum: 100 }
  has_many  :bikes
end

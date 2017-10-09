class Bike < ActiveRecord::Base
  validates :name, :description, :category_id, presence: true
  validates :name, length: { maximum: 200 }
  validates :description, length: { maximum: 10000 }
  validates :name, uniqueness: { case_sensitive: false }
  
  belongs_to :user
  belongs_to :category
  has_one    :comment
  
  mount_uploaders :images, ImageUploader
  serialize :images, Array

  scope :search_name, ->(search) { where("name LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%") }
  scope :used_bikes, ->(id) { where.not("used_bike LIKE ?", "%,#{id},%") }
end

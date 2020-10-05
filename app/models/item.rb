class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping

  has_one_attached :image
  belongs_to :user

  validates :name, :text, :category, :status, :delivery, :prefecture_id, :shipping_id, :price, :image, presence:true
  validates :category, :status, :delivery, :prefecture_id, :shipping_id, numericality: { other_than: 1 } 
  validates :price,numericality:{only_integer:true,greater_than_or_equal_to:300,less_than_or_equal_to:9999999}
end
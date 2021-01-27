class Article < ApplicationRecord
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  has_many :likes, dependent: :destroy


  def has_liked?(user)
    likes.find_by(user_id: user.id).present?
  end



end
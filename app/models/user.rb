class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :profile, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  def prepare_profile
    profile || build_profile
  end
  
  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'Ellipse.png'
    end
  end
  
  def has_liked?(article)
    likes.find_by(article_id: article.id)
  end
end

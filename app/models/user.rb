class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :profile, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  
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
  
  def follow!(user)
    if user.is_a?(User)
      user_id = user.id
    else
      user_id = user
    end
      following_relationships.create!(following_id: user_id)
  end
  
  def unfollow!(user)
    if user.is_a?(User)
      user_id = user.id
    else
      user_id = user
    end
    following_relationships.find_by(following_id: user_id).destroy!
  end
  
  def follow?(user)
    following_relationships.find_by(following_id: user.id)
  end
  
  def has_liked?(article)
    likes.find_by(article_id: article.id)
  end
end

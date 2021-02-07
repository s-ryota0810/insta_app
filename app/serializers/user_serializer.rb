class UserSerializer < ActiveModel::Serializer
  include Concerns::ImageUrl
  attributes :account, :avatar_image
  
  has_many :comments
  
  
  def avatar_image
    url_for(object.avatar_image)
  end
  
end

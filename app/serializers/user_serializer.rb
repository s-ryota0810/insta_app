class UserSerializer < ActiveModel::Serializer
  
  attributes :account, :avatar_image
  has_many :comments
  
end

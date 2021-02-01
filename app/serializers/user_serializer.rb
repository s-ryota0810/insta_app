class UserSerializer < ActiveModel::Serializer
  attributes :account, :avatar_image
  has_one :profile
end

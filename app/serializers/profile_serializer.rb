class ProfileSerializer < ActiveModel::Serializer
  has_one_attached :avatar
  belongs_to :user
end

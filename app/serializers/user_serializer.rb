class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :account, :avatar_image
  
  def avatar_image
    url_for(object.avatar_image)
  end
  

end

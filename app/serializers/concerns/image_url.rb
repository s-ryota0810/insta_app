module Concerns
  module ImageUrl
    extend ActiveSupport::Concern
    include Rails.application.routes.url_helpers
  end
end
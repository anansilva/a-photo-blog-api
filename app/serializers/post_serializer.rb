class PostSerializer < ActiveModel::Serializer  
  include Rails.application.routes.url_helpers

  attributes :id, :created_at, :updated_at, :photo_thumbnail_url

  def photo_thumbnail_url
    rails_representation_path(object.photo.variant(resize_to_limit: [100, 100]), only_path: true) if object.photo.attached?
  end
end

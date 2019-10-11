class PostSerializer < ActiveModel::Serializer  
  include Rails.application.routes.url_helpers

  attributes :id, :created_at, :updated_at, :photo

  def photo
    rails_blob_path(object.photo, only_path: true) if object.photo.attached?
  end
end
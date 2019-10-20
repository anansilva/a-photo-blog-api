class Post < ApplicationRecord
  has_one_attached :photo

  belongs_to :user

  validate :correct_image_mime_type

  private

  def correct_image_mime_type
    return if photo.attached? && photo.content_type.in?(%w[image/png image/jpg image/jpeg])

    errors.add(:document, 'Must be a png or jpg image file')
  end
end

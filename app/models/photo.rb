class Photo < ApplicationRecord
  include PhotoImageUploader::Attachment(:image)

  belongs_to :photographer
  belongs_to :category, optional: true

  has_many :likes
  has_many :views, as: :viewable
end

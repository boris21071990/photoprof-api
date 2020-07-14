class Photographer < ApplicationRecord
  include PhotographerImageUploader::Attachment(:image)

  belongs_to :user
  belongs_to :city

  has_many :photos
  has_many :categories, -> { distinct }, through: :photos
  has_many :enabled_photos, -> { where(enabled: true) }, class_name: "Photo"
  has_many :likes
end

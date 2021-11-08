class Photographer < ApplicationRecord
  include PhotographerImageUploader::Attachment(:image)

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  searchkick
  scope :search_import, -> { where(enabled: true).includes(:city, :categories) }

  belongs_to :user
  belongs_to :city

  has_many :photos, dependent: :destroy
  has_many :categories, -> { distinct }, through: :photos
  has_many :enabled_photos, -> { where(enabled: true) }, class_name: "Photo"
  has_many :likes

  def full_name
    [first_name, last_name].join(" ").strip
  end

  def search_data
    {
        city_id: city.id,
        category_ids: categories.pluck(:id),
        created_at: created_at
    }
  end

  def should_index?
    enabled
  end
end

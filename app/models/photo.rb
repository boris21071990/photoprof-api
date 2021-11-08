class Photo < ApplicationRecord
  include PhotoImageUploader::Attachment(:image)

  searchkick
  scope :search_import, -> { where(enabled: true).includes(:category) }

  belongs_to :photographer
  belongs_to :category, optional: true

  has_many :likes
  has_many :views, as: :viewable

  def search_data
    {
        category_id: category.id,
        created_at: created_at
    }
  end

  def should_index?
    enabled
  end
end

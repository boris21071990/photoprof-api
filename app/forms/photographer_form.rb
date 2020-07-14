class PhotographerForm
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :city_id

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :city_id, presence: true
  validate :city_existence

  private

  def city_existence
    errors.add(:city_id, "is not selected") unless City.exists?(id: city_id)
  end
end

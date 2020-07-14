class Like < ApplicationRecord
  belongs_to :photographer
  belongs_to :photo, counter_cache: true
end

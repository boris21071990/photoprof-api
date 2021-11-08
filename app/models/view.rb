class View < ApplicationRecord
  belongs_to :viewable, polymorphic: true, counter_cache: :views_count
end

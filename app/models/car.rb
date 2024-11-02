class Car < ApplicationRecord
  belongs_to :brand

  validates_presence_of :name, :car_type, :is_used, :release_year
end

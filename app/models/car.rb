class Car < ApplicationRecord
  belongs_to :brand

  validates_presence_of :name, :car_type, :release_year

  def brand_name
    brand.brand_name
  end
end

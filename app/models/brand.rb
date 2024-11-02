class Brand < ApplicationRecord
  # model association
  has_many :cars, dependent: :destroy

  # validations
  validates_presence_of :brand_name, :created_by
end

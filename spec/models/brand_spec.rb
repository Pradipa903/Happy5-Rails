require 'rails_helper'

RSpec.describe Brand, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:cars).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:brand_name) }
  it { should validate_presence_of(:created_by) }
end

require 'rails_helper'

RSpec.describe Car, type: :model do
  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:brand) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:car_type) }
  it { should validate_presence_of(:is_used) }
  it { should validate_presence_of(:release_year) }
end

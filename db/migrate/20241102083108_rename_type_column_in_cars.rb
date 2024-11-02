class RenameTypeColumnInCars < ActiveRecord::Migration[7.2]
  def change
    rename_column :cars, :type, :car_type
  end
end

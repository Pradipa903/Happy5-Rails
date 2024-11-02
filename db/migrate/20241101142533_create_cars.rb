class CreateCars < ActiveRecord::Migration[7.2]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :type
      t.integer :release_year
      t.boolean :is_used
      t.references :brand, foreign_key: true

      t.timestamps
    end
  end
end

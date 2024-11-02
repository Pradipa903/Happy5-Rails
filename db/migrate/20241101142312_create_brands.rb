class CreateBrands < ActiveRecord::Migration[7.2]
  def change
    create_table :brands do |t|
      t.string :brand_name
      t.string :created_by

      t.timestamps
    end
  end
end

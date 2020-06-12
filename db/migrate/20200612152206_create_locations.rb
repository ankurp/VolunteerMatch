class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end

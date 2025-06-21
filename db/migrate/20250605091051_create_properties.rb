class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :property_address
      t.integer :number_of_guests
      t.text :description
      t.integer :price_per_night
      t.string :property_image_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

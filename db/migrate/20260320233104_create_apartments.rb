class CreateApartments < ActiveRecord::Migration[8.0]
  def change
    create_table :apartments do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone

      t.timestamps
    end

    add_index :apartments, :email, unique: true
  end
end

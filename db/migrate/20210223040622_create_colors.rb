class CreateColors < ActiveRecord::Migration[6.1]
  def change
    create_table :colors do |t|
      t.string :name
      t.string :color
      t.string :pantone
      t.integer :year

      t.timestamps
    end
  end
end

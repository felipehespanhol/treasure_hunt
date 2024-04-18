class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.float :treasure_x
      t.float :treasure_y
      t.float :closest_distance

      t.timestamps
    end
  end
end

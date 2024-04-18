class AddWinnerToMatches < ActiveRecord::Migration[7.1]
  def change
    add_reference :matches, :winner, foreign_key: { to_table: :users }
  end
end

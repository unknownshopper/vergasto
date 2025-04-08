class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :full_name
      t.decimal :amount
      t.string :image

      t.timestamps
    end
  end
end

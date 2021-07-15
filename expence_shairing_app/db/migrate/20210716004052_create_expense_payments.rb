class CreateExpensePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :expense_payments do |t|
    	t.integer :expense_id
    	t.integer :group_id
    	t.decimal :amount
    	t.string :description

      t.timestamps
    end
  end
end

class CreatePaidUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :paid_users do |t|
    	t.integer :expense_payment_id
    	t.integer :user_id
    	t.decimal :share_amount
      t.timestamps
    end
  end
end

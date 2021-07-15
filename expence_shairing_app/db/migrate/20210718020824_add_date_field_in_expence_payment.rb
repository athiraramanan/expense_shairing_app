class AddDateFieldInExpencePayment < ActiveRecord::Migration[6.1]
  def change
  	 add_column :expense_payments, :date, :datetime
  end
end

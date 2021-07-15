class ExpensePayment < ApplicationRecord
	belongs_to :expense
	belongs_to :group
	has_many :paid_users
end

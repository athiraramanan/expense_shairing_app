class ExpensePayment < ApplicationRecord
	belongs_to :expense
	belongs_to :group
	has_many :paid_users
	delegate :name, to: :expense, allow_nil: true
end

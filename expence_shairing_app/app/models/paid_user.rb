class PaidUser < ApplicationRecord
	belongs_to :expense_payment
	belongs_to :user
	validates :expense_payment_id, uniqueness: { scope: :user_id }
end

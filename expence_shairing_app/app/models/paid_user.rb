class PaidUser < ApplicationRecord
	belongs_to :expense_payment
	belongs_to :user
	validates :expense_payment_id, uniqueness: { scope: :user_id }
	delegate :first_name, to: :user, allow_nil: true
	delegate :date, to: :expense_payment, allow_nil: true
end

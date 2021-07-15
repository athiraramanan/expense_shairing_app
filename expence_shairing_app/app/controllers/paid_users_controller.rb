class PaidUsersController < ApplicationController

  def create
    paid_user = PaidUser.new(paid_users_params)
    total_amount = expense_payment.amount
    if total_amount >= (payable_amount + paid_users_params['share_amount'].to_i)
      if paid_user.save
    	  redirect_to expense_payment_path(paid_user.expense_payment_id), notice: 'Successfully added your share.'
  	  else
        redirect_to expense_payment_path(paid_user.expense_payment_id), notice: 'Alredy added your share.'
      end
    else
      flash[:notice] = "Expense is lesser than paid amount."
      redirect_to expense_payment_path(paid_user.expense_payment_id)
  	end
  end

  def payable_amount
    paid_amount = expense_payment.paid_users&.pluck(:share_amount).sum
  end

  def expense_payment
    ExpensePayment.find(paid_users_params['expense_payment_id'])
  end

  def paid_users_params
    params.require(:paid_user).permit(:share_amount, :expense_payment_id, :user_id)
  end
end

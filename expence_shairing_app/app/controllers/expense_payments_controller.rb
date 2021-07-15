class ExpensePaymentsController < ApplicationController
	
	def new
    @expense_payment = ExpensePayment.new
  end

	def index
		@expense_payments = ExpensePayment.all
		@expense_payment = ExpensePayment.new
  end

  def create
    @expense_payment = ExpensePayment.new(expense_payment_params)
    if @expense_payment.save
      redirect_to expense_payments_path, notice: 'Expense added successfully'
    else
      redirect_to :back
    end
  end

  def show
    @expense_payment = ExpensePayment.where(id: params[:id]).last
    @share_holders = @expense_payment.group.users
    @paid_users = @expense_payment.paid_users.includes(:user).order('id desc')
    @paid_user = PaidUser.new
  end

  def expense_payment_params
    params.require(:expense_payment).permit(:amount, :expense_id, :group_id, :description)
  end
end

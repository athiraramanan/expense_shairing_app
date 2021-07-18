class DashboardChartController < ApplicationController
	
	def index	
	end

	def plot
		data_set = ExpensePayment.where(:date => params['start_date'].to_date.beginning_of_day..params['end_date'].to_date.end_of_day).pluck(:expense_id,:amount).group_by(&:first)
		data_set = format_expense_data_set(data_set)
		render json: {data: data_set}
	end

	def format_expense_data_set(data_set)
		new_data={}
		data_set.each do |k, v|
			new_data[k]=v.map{|x| x[1]}.sum
		end
		new_data = new_data.to_a
		new_data.map{|x| x[0] = Expense.where(id: x[0])&.last&.name}
		new_data.map{|x| x[1]=x[1].to_f}
		new_data
	end

	def expense_balance
		expense_payment = ExpensePayment.find params['expense']
		@total_expense = expense_payment.amount
		@paid_users = expense_payment.paid_users
		@non_paid_users = User.where(id: expense_payment.group.users.pluck(:id)-@paid_users.pluck(:user_id))
		@share_amount = (@total_expense / expense_payment.group.users.count)
	end

	def expense_table
		if (params['group_id'] ||  params['user_id'])
      search_expense
		else
			expenses = ExpensePayment.includes(:expense,:group).includes(:expense).all
			group_expenses_share(expenses)
		end
	end

	def search_expense
		@payments=[]
		if params['group_id'].present?
   	  expenses = ExpensePayment.includes(:expense,:group).where(group_id: params['group_id'])
   	  group_expenses_share(expenses)
   	elsif params['user_id'].present?
   		expenses = PaidUser.where(user_id:  params['user_id'])
   		personal_expenses_share(expenses)
   	end
  end

  def group_expenses_share(expenses)
  	@payments=[]
  	expenses.each do |exp|
  		users = if params['user_id'].present?
  							exp.paid_users.where(user_id: params['user_id'])
  						else
  							exp.paid_users
  						end
		 	users.each do |exp_user|
	   		payment = [exp_user.expense_payment.name, exp_user.first_name, exp_user.expense_payment.group.name, exp_user.share_amount, exp_user.date]
	 	  	@payments << payment
	 	  end
	 	 end
  end

  def personal_expenses_share(expenses)
  	@payments=[]
	 	expenses.each do |exp_user|
   		payment = [exp_user.expense_payment.name, exp_user.first_name, exp_user.expense_payment.group.name, exp_user.share_amount, exp_user.date]
 	  	@payments << payment
 	  end
  end

end
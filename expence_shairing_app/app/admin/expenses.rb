ActiveAdmin.register Expense do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :amount
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :amount]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
ActiveAdmin.register Expense do
  permit_params :name

  filter :name

  # index for credit_rate
  index do
    selectable_column
    id_column
    column :name
    actions
  end

  # credit_rate inputs
  form do |f|
    f.inputs 'Expense' do
      f.input :name
    end
    f.actions
  end

  controller do
     def create
        @expense = Expense.new(expense_params)
        @expense.save(validate: false)
        if @expense.save
          redirect_to admin_expenses_path
        else
          redirect_to :back
        end
     end
     def expense_params
      params.require(:expense).permit(:name)
    end
  end
end
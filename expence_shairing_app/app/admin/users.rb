ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email

  filter :first_name
  filter :last_name
  filter :email

  # index for credit_rate
  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    actions
  end

  # credit_rate inputs
  form do |f|
    f.inputs 'Users' do
      f.input :first_name
      f.input :last_name
      f.input :email
    end
    f.actions
  end

  controller do
     def create
        @user = User.new(user_params)
        @user.save(validate: false)
        if @user.save
          redirect_to admin_users_path
        else
          redirect_to :back
        end
     end
     def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
  end
end
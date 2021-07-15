ActiveAdmin.register Group do
  permit_params :name,:owner_id,  user_ids: []

  filter :name
  # index for credit_rate
  index do
    selectable_column
    column :name
    actions
  end
  
  show do |group|
    attributes_table do
      row :id
      row :name
      row 'Owner' do |gro|
        gro.owner.first_name
      end
      row 'Members' do |gro|
        gro.users.pluck(:first_name).join(", ")
      end
    end
  end

  # credit_rate inputs
  form do |f|
    f.inputs 'Group' do
      f.input :name
      f.input :owner_id, label: 'Members', as: :select, collection: User.all.map{|r| [r.first_name, r.id]}, include_blank: false, input_html: { class: "chosen-input" , multiple: false}
      f.input :users, label: 'Members', as: :select, collection: User.all.map{|r| [r.first_name, r.id]}, include_blank: false, input_html: { class: "chosen-input" , multiple: true}
    end
    f.actions
  end

  controller do
     def create
        @group = Group.new(group_params)
        @group.save(validate: false)
        binding.pry
        if @group.save(validate: false)
          redirect_to admin_groups_path
        else
          redirect_to :back
        end
     end
     def group_params
      params.require(:group).permit(:name, :owner_id,user_ids: [])
    end
  end
end
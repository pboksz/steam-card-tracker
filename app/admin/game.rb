ActiveAdmin.register Game do
  actions :all, :except => [:show]

  config.filters = false
  config.sort_order = "name_asc"
  config.paginate = false

  index :download_links => false do
    column :id
    column :name
    actions
  end

  controller do
    def permitted_params
      params.permit :game => [:name]
    end
  end
end

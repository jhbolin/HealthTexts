class AddCategoryToHealthConditions < ActiveRecord::Migration
  def change
    add_column :health_conditions, :category, :string
  end
end

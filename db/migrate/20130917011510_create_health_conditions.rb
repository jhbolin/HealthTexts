class CreateHealthConditions < ActiveRecord::Migration
  def up
    create_table :health_conditions do |t|
      t.string :name
    end
  end

  def down
    drop_table :health_conditions
  end
end

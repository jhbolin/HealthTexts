class CreateHealthConditionSubscriptions < ActiveRecord::Migration
  def up
    create_table :health_condition_subscriptions do |t|
      t.integer :user_id
      t.integer :health_condition_id
      t.timestamps
    end
  end

  def down
    drop_table :health_condition_subscriptions
  end
end

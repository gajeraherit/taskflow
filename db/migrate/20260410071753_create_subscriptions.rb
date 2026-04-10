class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.integer :workspace_id
      t.string :stripe_customer_id
      t.string :stripe_subscription_id
      t.string :plan
      t.string :status

      t.timestamps
    end
  end
end

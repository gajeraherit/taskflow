class CreateWorkspaceMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :workspace_memberships do |t|
      t.integer :user_id
      t.integer :workspace_id
      t.string :role

      t.timestamps
    end
  end
end

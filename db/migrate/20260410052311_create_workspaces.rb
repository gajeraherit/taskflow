class CreateWorkspaces < ActiveRecord::Migration[7.1]
  def change
    create_table :workspaces do |t|
      t.string :name
      t.string :slug
      t.integer :owner_id

      t.timestamps
    end
  end
end

class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :workspace_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end

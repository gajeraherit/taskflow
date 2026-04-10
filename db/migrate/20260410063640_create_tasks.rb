class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :project_id
      t.integer :user_id
      t.string :status
      t.string :priority
      t.date :due_date

      t.timestamps
    end
  end
end

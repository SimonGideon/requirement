class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.references :client, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.date :desired_completion_date
      t.integer :budget_cents
      t.integer :status
      t.text :notes

      t.timestamps
    end
  end
end

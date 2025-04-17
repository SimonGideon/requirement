class CreateRequirements < ActiveRecord::Migration[8.0]
  def change
    create_table :requirements do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :priority
      t.integer :category
      t.boolean :must_have
      t.text :acceptance_criteria

      t.timestamps
    end
  end
end

class ModifyUsersForCustomAuth < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :email
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at
    
    add_column :users, :business_name, :string, null: false
    add_column :users, :security_question, :string, null: false
    add_column :users, :security_answer, :string, null: false
    
    add_index :users, :business_name, unique: true
  end
end

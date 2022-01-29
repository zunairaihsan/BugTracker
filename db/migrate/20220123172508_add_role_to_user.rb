class AddRoleToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer
    add_column :users, :full_name, :string
    #Ex:- :null => false
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end

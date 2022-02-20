class ChangeBugTitleColoumn < ActiveRecord::Migration[7.0]
  def change
    change_column :bugs, :title
  end
end

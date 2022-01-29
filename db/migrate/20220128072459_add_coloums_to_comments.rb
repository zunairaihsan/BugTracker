class AddColoumsToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :users, index: true
    add_reference :comments, :bugs, index: true
    add_column :comments, :time, :datetime
    add_column :comments, :content ,:string
  end
end

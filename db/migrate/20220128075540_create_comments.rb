class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :bug, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :time
      t.string :content
      t.timestamps
    end
  end
end

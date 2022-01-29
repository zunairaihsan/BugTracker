class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|
      t.string :title, null: false 
      t.text :description
      t.datetime :deadline
      t.references :created_by
      t.references :project, foreign_key: true
      t.integer :bugtype , null: false
     

      t.timestamps
    end
  end
end

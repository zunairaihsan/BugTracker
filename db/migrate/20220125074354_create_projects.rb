class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|

      t.string :title, null: false
      t.text :description
      t.references :creator
      t.timestamps
    end
  end
end

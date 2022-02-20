class AddReferenceAssignedTo < ActiveRecord::Migration[7.0]
  def change
    add_reference :bugs, :assigned_to
  end
end

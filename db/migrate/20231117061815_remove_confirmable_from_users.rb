class RemoveConfirmableFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :confirmable, :string
  end
end

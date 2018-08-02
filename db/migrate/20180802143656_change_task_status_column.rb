class ChangeTaskStatusColumn < ActiveRecord::Migration[5.2]
  def change
    change_table :tasks do |t|
      t.change :status, :integer, default: 0
    end
  end
end

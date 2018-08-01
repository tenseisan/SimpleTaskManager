# frozen_string_literal: true

class AddCreatorAssigneeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :creator_id, :integer, index: true
    add_column :tasks, :assignee_id, :integer
  end
end

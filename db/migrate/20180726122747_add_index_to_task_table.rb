# frozen_string_literal: true

class AddIndexToTaskTable < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :creator_id
  end
end

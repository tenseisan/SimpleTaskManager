# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.string :status
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end

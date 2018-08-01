# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable

  has_many :created_tasks, foreign_key: :creator_id, class_name: 'Task',
                           inverse_of: :user, dependent: :destroy
  has_many :assigned_tasks, foreign_key: :assignee_id, class_name: 'Task',
                            inverse_of: :user, dependent: :destroy

  validates :first_name, :last_name, presence: true, length: { maximum: 30 }
  validates :email, uniqueness: true
end

# frozen_string_literal: true

class Task < ApplicationRecord
  STATUSES = { untaken: 0, in_work: 1, complete: 3 }.freeze
  enum status: STATUSES

  scope :completed, -> { where(status: 'complete') }
  scope :in_work, -> { where(status: 'in_work') }
  scope :untaken, -> { where(status: 'untaken') }

  belongs_to :user, foreign_key: :creator_id, class_name: 'User',
                    inverse_of: :created_tasks

  validates :title, :creator_id, presence: true
  validates :title, length: { maximum: 30 }
end

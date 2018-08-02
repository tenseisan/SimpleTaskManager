# frozen_string_literal: true

class Task < ApplicationRecord
  STATUSES = %w[untaken in_work complete].freeze

  scope :completed, -> { where(status: 'complete') }
  scope :in_work, -> { where(status: 'in_work') }
  scope :untaken, -> { where(status: 'untaken') }

  belongs_to :user, foreign_key: :creator_id, class_name: 'User',
                    inverse_of: :created_tasks
  validates :status, inclusion: STATUSES, allow_nil: true
  validates :title, :creator_id, presence: true

  before_validation :set_status

  def complete
    self.status = 'complete'
    self.finished_at = Time.zone.now
    save
  end

  def take
    self.status = 'in_work'
    self.started_at = Time.zone.now
    save
  end

  private

  def set_status
    self.status = 'untaken' if status.nil? && assignee_id?
  end
end

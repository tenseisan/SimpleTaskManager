# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:task) { FactoryBot.create(:task, user: user) }

  describe 'validates' do
    context 'presence' do
      it { should validate_presence_of :title }
      it { should validate_presence_of :creator_id }
    end

    context 'inclusion' do
      it 'should allow valid values' do
        Task::STATUS.each do |v|
          should allow_value(v).for(:status)
        end
      end
    end
  end

  describe '#complete_task' do
    it 'should set complete status and finished time' do
      task.complete_task

      expect(task.status).to eq 'complete'
      expect(task.finished_at).to be
    end
  end

  describe '#take_task' do
    it 'should set in work status and start time' do
      task.take_task

      expect(task.status).to eq 'in_work'
      expect(task.started_at).to be
    end
  end

  describe 'scopes' do
    it '#completed should return completed tasks' do
      task.complete_task
      expect(Task.completed.count).to be(1)
    end
    it '#in_work should return in work tasks' do
      task.take_task
      expect(Task.in_work.count).to be(1)
    end
    it '#untaken should return untaken tasks' do
      expect(Task.untaken.count).to be
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end

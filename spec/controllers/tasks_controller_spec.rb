# frozen_string_literal: true

require 'rails_helper'
require 'devise'

RSpec.describe TasksController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let!(:task) do
    FactoryBot.create(:task,
                      user: user, creator_id: user.id, assignee_id: user.id)
  end
  let(:task_params) { task.attributes }

  context 'usual user' do
    before { sign_in user }

    describe 'GET #new' do
      it 'should respond and create Task' do
        get :new
        expect(response.status).to be(200)
        expect(response).to render_template(:new)
        expect(assigns(:task)).to be_a_new(Task)
      end
    end

    describe 'POST #create' do
      it 'valid attributes' do
        post :create, params: { id: user.id, task: task_params }

        expect(task).to be_kind_of ActiveRecord::Base
        expect(task.creator_id).to eq(user.id)
        expect(response).to redirect_to(authenticated_root_path)
      end

      it 'invalid attributes' do
        post :create, params: { id: user.id, task: { title: nil } }
        expect(response).to render_template(:new)
      end
    end

    describe 'PATCH #update' do
      it 'valid attributes' do
        patch :update, params: { id: task.id, task: { title: 'anime' } }
        task.reload
        expect(task.title).to eq 'anime'
        expect(flash[:notice]).to be
        expect(response).to redirect_to(user)
      end

      it 'invalid parameters' do
        patch :update, params: { id: task.id, task: { title: nil } }
        expect(task).to render_template :edit
      end
    end

    describe 'DELETE #destroy' do
      it 'task count change' do
        delete :destroy, params: { id: task.id }
        expect(Task.all).not_to include task
        expect(response).to redirect_to(authenticated_root_path)
      end
    end

    it '#complete' do
      put :complete, params: { id: task.id }
      task.reload
      expect(task.status).to eq 'complete'
    end

    it '#take' do
      put :take, params: { id: task.id }
      task.reload
      expect(task.status).to eq 'in_work'
    end
  end
end

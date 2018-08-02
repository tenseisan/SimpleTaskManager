# frozen_string_literal: true

require 'rails_helper'
require 'devise'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:user_params) { user.attributes }

  context 'anonym user' do
    describe 'GET #show' do
      it 'response and redirect to new_session' do
        get :profile

        expect(response.status).not_to eq(200)
        expect(response).to redirect_to(unauthenticated_root_path)
      end

      describe 'GET #edit' do
        it 'response and redirect to new_session' do
          get :edit, params: { id: 1 }

          expect(response.status).not_to eq(200)
          expect(response).to redirect_to(new_user_session_path)
          expect(flash[:alert]).to be
        end
      end

      describe 'PATCH #update' do
        it 'should be kicked from update' do
          patch :update, params: user_params
          user.reload
          expect(response.status).not_to eq(200)
          expect(response).to redirect_to(new_user_session_path)
          expect(flash[:alert]).to be
        end
      end
    end
  end

  context 'usual user' do
    before { sign_in user }

    describe 'GET #show' do
      it 'response to own profile page' do
        get :show, params: { id: user.id }
        expect(response.status).to eq(200)
      end

      it 'assigns it to @user' do
        expect(assigns(:user)).to eq @user
      end
    end

    describe 'GET #edit' do
      it 'should response and render form' do
        get :edit, params: { id: user.id }
        expect(response.status).to eq(200)
      end
    end

    describe 'PATCH #update' do
      it 'valid attributes' do
        patch :update, params: { id: user.id,
                                 user: { first_name: 'First' } }
        user.reload
        expect(user.first_name).to eq 'First'
        expect(flash[:notice]).to be
        expect(response).to redirect_to(user)
      end
    end

    it 'invalid attributes' do
      patch :update, params: { id: user.id, user: { first_name: nil } }
      user.reload
      expect(user).to render_template :edit
    end
  end
end

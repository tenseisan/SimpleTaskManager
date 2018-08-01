# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validates' do
    FactoryBot.create(:user)

    context 'presence' do
      it { should validate_presence_of :first_name }
      it { should validate_presence_of :last_name }
      it { should validate_presence_of :email }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end

    context 'length' do
      it { should validate_length_of(:first_name).is_at_most(30) }
      it { should validate_length_of(:last_name).is_at_most(30) }
    end

    context 'associations' do
      it { is_expected.to have_many(:created_tasks) }
      it { is_expected.to have_many(:assigned_tasks) }
    end
  end
end

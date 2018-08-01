# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title 'Foo'
    description 'Bar'
    creator_id 1
    status 'untaken'
    association :user
  end
end

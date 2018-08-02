# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title 'Foo'
    description 'Bar'
    status 'untaken'
    association :user
  end
end

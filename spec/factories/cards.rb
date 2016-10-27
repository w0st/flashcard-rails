FactoryGirl.define do
  factory :card do
    front Faker::Hipster.word
    back Faker::Hipster.word
  end
end
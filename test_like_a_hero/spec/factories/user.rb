FactoryBot.define do
  factory :user do
    nickname { FFaker::Lorem.word }
    kind { %i[knight wizard].sample }
    level { FFaker::Random.rand(1..99) }
  end
end

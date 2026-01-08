FactoryBot.define do
  factory :event do
    title { "Dinner" }
    description { "Dinner with friends" }
    location { "Sogutozu" }
    date { Date.tomorrow }
    time { Time.zone.parse("19.00") }
  end
end

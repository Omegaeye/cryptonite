FactoryBot.define do
  factory :coin do
    name { "MyString" }
    symbol { "MyString" }
    usd_price { "9.99" }
    btc_price { "MyString" }
    percent_chant { 1 }
  end
end
